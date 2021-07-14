# 같은 user 가 생성한 데이터 중, 가장 최근의 timestamp 데이터만 남긴 뒤 출력하는 방법?


WITH table1 AS (
  SELECT *, (
             FIRST_VALUE(time) OVER (
                                     PARTITION BY document ORDER BY time DESC
                                    )
            ) as lasttime
  FROM `samplepj-318810.diffrent_table.diffrent_table`
)
SELECT table1.time, table1.id, table1.document, table1.value, table1.etc
FROM table1
WHERE (timestamp =table1.lasttime) AND (document_name =table1.id)
