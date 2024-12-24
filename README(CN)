# OpenGauss与PostgreSQL的基准测试：对比分析
## 基于SQL的OpenGauss与PostgreSQL数据库对比
SqlGenerator是一个用于生成多个插入语句的Java程序，目的是为数据库提供数据；SqlGenerator也可以用来生成多个事务来提供数据；test_1 到 test_4 对应着我在.md文章中的四个性能测试项目。更多内容请参考.md文件，文章目前为中文版本，英文版将很快更新。

## 你可以通过以下步骤复制我的实验，并验证OpenGauss数据库的性能：

#### 使用Docker设置环境
首先，你可以使用Docker为这两个数据库设置环境（可以参考 openGaussGuideline.pdf 文件），然后使用Datagrip连接数据库。完成连接后，打开两个控制台分别连接到两个数据库，并按照下面的步骤进行测试。

#### 使用SqlGenerator生成插入数据
你可以使用SqlGenerator生成多个插入语句（你可以在这个Java程序中调整列和行的数量）：

```
public static void main(String[] args) {
    // 输入设置
    long m = 50000;  // 行数设置
    long n = 2;  // 列数设置
    String[] columnNames = {"id", "name", "age"};
    String[] columnTypes = {"int", "varchar", "long"};
}
```  

#### 插入数据并比较运行时间
你可以分别在两个控制台中执行这些插入操作，查看它们的运行时间，并与我实验中的结果进行对比。

#### 进行DML操作并分析结果
完成插入操作后，你将得到一个包含大量数据的表格。你可以尝试执行 UPDATE、SELECT、SUM、AVERAGE 等操作，并与我实验中的结果进行对比。提示：你可以在这些简单的DML操作前加上 EXPLAIN ANALYSE，以查看每个步骤的执行时间和内存占用情况。

#### 测试数据库锁机制
同时，你可以打开多个控制台，测试这两个数据库的锁机制。详细过程可以参考.md文件中的SQL内容。

#### 使用SqlGenerator生成多个事务
接着，你可以使用SqlGenerator生成多个事务，可以更改事务的数量或内容来测试不同情况。同样，在测试时加上EXPLAIN ANALYSE，查看详细的执行信息。

#### 导入数据并比较OpenGauss与PostgreSQL的表现
你可以尝试将数据（例如.csv文件）导入数据库，测试OpenGauss在这种方式下的性能是否优于PostgreSQL。

#### 多表连接测试
最后，我的实验包括多表连接的测试，你可以在第四个SQL文件中找到源SQL代码，并与我的结果进行对比。我的工作中可能没有完全展示复杂性，你也可以尝试更复杂的测试。

## 备注
此工作由一名新手创建，可能存在许多不当之处，如果你打算按照我的方式进行测试，请务必小心。更多详细信息可以参考.md文件。
