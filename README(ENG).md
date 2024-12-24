# Benchmarking-openGauss-Against-PostgreSQL-A-Comparative-Analysis
sql-based database comparisons between OpenGuass and PostgreSql

SqlGenerator is a java programme to generate multiple insert orders to give datas;
SqlGenerator is a java programme to generate multiple transantions to give datas;
test_1 ~ 4 corresponds with the property-tests in my .md article.
You can find more in .md and the article is in Chinese, the English version will be updated soon.

## You can replicate my experiment and verify the OpenGauss database by following these steps.
First you could use dockers to set the environment for this two databases and use Datagrip to make connections. After doing that you could open two console for two databases and make some tests as below.
1.You could use SqlGenerators to generate multiply insertions(you could adjust columns and rows in this Java programme)

```
public static void main(String[] args) {
        // Input settings here
        long m = 50000;  // row setting
        long n = 2;  // column setting
        String[] columnNames = {"id", "name", "age"};
        String[] columnTypes = {"int", "varchar", "long"};
```

2.Then you could do these insertions in the console seperately to see whether the running time comparison corresponds with my work.
3. Ok, so now you have a form with big amount of data. You could try UPDATE,SELECT,SUM,AVERAGE and so on, comparing your result with mine. P.A. you could add EXPLAIN ANALYSE at the beginning of these simple DML to see the time for different steps and the momery occupaid.
