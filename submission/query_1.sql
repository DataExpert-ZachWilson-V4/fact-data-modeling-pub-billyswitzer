--Query to remove duplicates from the nba_game_details leaving only one row per game_id, team_id, and player_id
--Most duplicates seem to be caused by rounding errors in percents, e.g. - 0.333 vs. 0.33299999999 - take the shorter of the two for readability
WITH dedupe AS (SELECT team_id,
	team_abbreviation,
	team_city,
	player_id,
	player_name,
	nickname,
	start_position,
	comment,
	min,
	fgm,
	fga,
	fg_pct,
	fg3m,
	fg3a,
	fg3_pct,
	ftm,
	fta,
	ft_pct,
	oreb,
	dreb,
	reb,
	ast,
	stl,
	blk,
	to,
	pf,
	pts,
	plus_minus,
    ROW_NUMBER() OVER (PARTITION BY game_id, team_id, player_id ORDER BY LENGTH(CAST(fg_pct AS VARCHAR)), LENGTH(CAST(ft_pct AS VARCHAR))) AS row_number
  FROM bootcamp.nba_game_details 
)
SELECT team_id,
  team_abbreviation,
  team_city,
  player_id,
  player_name,
  nickname,
  start_position,
  comment,
  min,
  fgm,
  fga,
  fg_pct,
  fg3m,
  fg3a,
  fg3_pct,
  ftm,
  fta,
  ft_pct,
  oreb,
  dreb,
  reb,
  ast,
  stl,
  blk,
  to,
  pf,
  pts,
  plus_minus
FROM dedupe
WHERE row_number = 1