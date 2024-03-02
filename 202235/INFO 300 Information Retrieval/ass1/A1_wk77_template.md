# Assignment 1

## Student(s)

+ Weimao Ke, wk77@drexel.edu
+ John Smith, jps2020@drexel.edu

## 1. Academic Honesty Statement

Please copy and paste **the academic honesty statement** here.

Student Names: __Weimao Ke and John Smith__

Date: __July 1, 2020__

You only need to submit this once for the entire course.
*You will not receive any grade without the statement*.

## 2. Assignment Data

1. breakthrough drug for schizophrenia
2. new schizophrenia drug
3. new approach for treatment of schizophrenia
4. new hopes for schizophrenia patients

## 3. Assignment Tasks


### 3.1. Term-Document Matrix Representation (1 point)

You can use a table like this for the matrix representation:

| Term       |   Doc 1  |  Doc 2  | Doc 3   | Doc 4   |
|------------|----------|---------|---------|---------|
| word1      |    1     |  0      |   0     |  1      |
| word2      |    0     |  0      |   1     |  1      |
| ...        |    .     |  .      |   .     |  .      |
| wordm      |    1     |  0      |   1     |  1      |

Replace table content with actual terms and values.

### 3.2. Inverted Index Representation (1 point)

Inverted index (table/figure) here.
Note that this is NOT the same as the above matrix.

### 3.3. Indexing with ElasticSearch (1 point)

```json
PUT /.../../.. {

}
PUT /... {}
...
```

### 3.4. Retrieval with ElasticSearch (0.5 points)

Request:

```json
GET /.../.. {

}
```

Response:
```json
{

}
```

### 3.5. Boolean Query

```sql
"schizophrenia" AND "drug"
```

#### 3.5.1. Manual Analysis (0.75 point)

1. Documents containing ```schizophrenia```:
2. Documents containing ```drug```:
3. Merging results of 1 and 2 with ```AND```:

#### 3.5.2. ElasticSearch Query (1 point)

Request:

```json
GET /.../.. {

}
```

Response:
```json
{

}
```

### 3.6. Compound Query

```sql
"for" AND ("drug" OR "approach")
```

#### 3.6.1. Manual Analysis (1.25 point)

1. Documents containing ```for```:
2. Documents containing ```drug```:
3. Documents containing ```approach```:
4. Merging results of 2 and 3 with ```OR```:
5. Merging results of 1 and 4 with ```AND```:

#### 3.6.2. ElasticSearch Query (1.5 points)

Request:

```json
GET /.../.. {

}
```

Response:
```json
{

}
```
