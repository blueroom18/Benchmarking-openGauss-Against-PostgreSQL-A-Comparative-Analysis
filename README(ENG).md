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
        // 示例输入
        long m = 50000;  // 总行数
        long n = 2;  // 列数
        String[] columnNames = {"id", "name", "age"};
        String[] columnTypes = {"int", "varchar", "long"};

