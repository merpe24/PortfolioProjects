SELECT 
	*
FROM
	Portfolio_Project..CovidDeaths
WHERE
	continent IS NOT NULL
ORDER BY
	3,4



SELECT 
	location, date, total_cases, new_cases, total_deaths, population
FROM
	Portfolio_Project..CovidDeaths
ORDER BY
	1, 2

SELECT 
	location, date, total_cases, total_deaths, ROUND(((total_deaths/total_cases)*100), 2) AS death_percentage
FROM
	Portfolio_Project..CovidDeaths
WHERE
	location like '%Thai%'
ORDER BY
	1, 2

SELECT 
	location, population,
	MAX(total_cases) AS highest_inflection_count, 
	MAX((total_cases/population)*100) AS inflection_percentage
FROM
	Portfolio_Project..CovidDeaths
GROUP BY
	location, population
ORDER BY
	inflection_percentage DESC

SELECT 
	location, population,
	MAX(CAST(total_deaths AS INT)) AS total_death_count, 
	MAX((total_deaths/population)*100) AS death_percentage
FROM
	Portfolio_Project..CovidDeaths
WHERE
	continent IS NOT NULL
GROUP BY
	location, population
ORDER BY
	total_death_count DESC


SELECT 
	location,
	MAX(CAST(total_deaths AS INT)) AS total_death_count, 
	MAX((total_deaths/population)*100) AS death_percentage
FROM
	Portfolio_Project..CovidDeaths
WHERE
	continent IS NULL
GROUP BY
	location
ORDER BY
	total_death_count DESC

SELECT 
	date, 
	SUM(CAST(new_cases AS INT)) AS total_cases, 
	SUM(CAST(new_deaths AS INT)) AS total_deaths,
	(SUM(CAST(new_deaths AS INT)) * 100.0 / NULLIF(SUM(CAST(new_cases AS INT)), 0)) AS death_percentage
FROM
	Portfolio_Project..CovidDeaths
WHERE
	continent IS NOT NULL
GROUP BY
	date
ORDER BY
	1, 2

SELECT  
	SUM(CAST(new_cases AS INT)) AS total_cases, 
	SUM(CAST(new_deaths AS INT)) AS total_deaths,
	(SUM(CAST(new_deaths AS INT)) * 100.0 / NULLIF(SUM(CAST(new_cases AS INT)), 0)) AS death_percentage
FROM
	Portfolio_Project..CovidDeaths
WHERE
	continent IS NOT NULL
ORDER BY
	1, 2


SELECT 
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS people_vaccinated
FROM
	Portfolio_Project..CovidDeaths AS dea
JOIN Portfolio_Project..CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
	AND vac.new_vaccinations IS NOT NULL
--ORDER BY
--	1, 2


--TEMP TABLE

DROP TABLE IF exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
people_vaccinated numeric
)




INSERT INTO 
	#PercentPopulationVaccinated
SELECT 
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS people_vaccinated
FROM
	Portfolio_Project..CovidDeaths AS dea
JOIN Portfolio_Project..CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
	AND vac.new_vaccinations IS NOT NULL


SELECT
	*, 
	(people_vaccinated/population)*100 AS population_vaccinated_percentage
FROM 
	#PercentPopulationVaccinated


-- Creating view to store data for later visualizations


CREATE VIEW PercentPopulationVaccinated AS
SELECT 
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS people_vaccinated
FROM
	Portfolio_Project..CovidDeaths AS dea
JOIN Portfolio_Project..CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
	AND vac.new_vaccinations IS NOT NULL
	
