# Which users gained the most reach per post? (Use: UserFollowers / TotalPosts)

SELECT 
  UserID,
  ROUND(MAX(UserFollowers) / COUNT(PostID), 0) AS ReachPerPost
FROM dataset
GROUP BY UserID
ORDER BY ReachPerPost DESC
;
