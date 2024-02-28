
# Index mappings

Before importing data, create an index with the following mappings:

```json
PUT /wk77_fake
{
  "mappings":{
    "properties" : {
      "author": {
        "type":"text",
        "analyzer":"standard"
      },
      "published": {
        "type":"date"
      },
      "title" : {
        "type" : "text",
        "analyzer": "english"
      },
      "content" : {
        "type" : "text",
        "analyzer": "english"
      },
      "spam_score": {
        "type": "float"
      },
      "likes": {
        "type": "integer"
      }
    }
  }
}
```

# Import and Index Data

Import data in fake.xlsx:
1. Change "text" column name to "content";
2. Use XSLX / CSV Import on Kibana to import the data to index /*yourusername_fake*

# Basic Query

Search "Presidential Election" on the *title* and *content* fields.

```json
GET /wk77_fake/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query":    "Presidential Election",
      "fields": ["title", "content" ]
    }
  }
}
```

# Boost Query

Boost the *title* field for a query:

```json
GET /wk77_fake/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query":    "Presidential Election",
      "fields": ["title^10", "content" ]
    }
  }
}
```

**^10** is to boost the title field 10 times.

# Update Related Fields to Avoid 0 Values

Before we continue, we would like to correct some values in the index.

First, let's make sure we have non-zero values for **likes** (by adding 1):

```json
POST /wk77_fake/_update_by_query
{
  "script" : {
      "source": "ctx._source.likes = Integer.parseInt(ctx._source.likes) + 1;",
      "lang": "painless",
      "params" : {
          "amount" : 1
      }
  },
  "query": {
    "match_all": {}
  }
}
```

Second, we do likewise to the **spam_score** field (by adding a small value 0.00001):

```json
POST /wk77_fake/_update_by_query
{
  "script" : {
      "source": "ctx._source.spam_score = Float.parseFloat(ctx._source.spam_score) + params.amount;",
      "lang": "painless",
      "params" : {
          "amount" : 0.00001
      }
  },
  "query": {
    "match_all": {}
  }
}
```



# Second Index

Now we will create a second index for custom similarity and scoring functions.

## Custom Similarity

Custom similarities with BM25 and DFR (divergence from randomness):

```json
PUT /wk77_fake2
{
  "settings": {
    "index": {
      "similarity": {
        "my_bm25": {
          "type": "BM25",
          "k1": 2.0,
          "b":1.0
        },
        "my_dfr": {
          "type": "DFR",
          "basic_model": "g",
          "after_effect": "l",
          "normalization": "h2",
          "normalization.h2.c": "3.0"
        }
      }
    }
  }
}
```

## Fields with different Similarity

**Content** field using BM25:

```json
PUT /wk77_fake2/_mapping
{
  "properties" : {
    "content" : {
      "type" : "text",
      "analyzer": "english",
      "similarity" : "my_bm25"
    }
  }
}
```

**Title** field using DFR:

```json
PUT /wk77_fake2/_mapping
{
  "properties" : {
    "title" : {
      "type" : "text",
      "analyzer": "english",
      "similarity" : "my_bm25"
    }
  }
}
```

**Author** field using boolean similarity:

```json
PUT /wk77_fake2/_mapping
{
  "properties" : {
    "author" : {
      "type" : "text",
      "analyzer": "standard",
      "similarity" : "boolean"
    }
  }
}
```

**Likes** field as a rank feature (positive), which will be used to boost a score:

```json
PUT /wk77_fake2/_mapping
{
  "properties" : {
    "likes" : {
      "type" : "rank_feature",
      "positive_score_impact": true
    }
  }
}
```

**Spam_score** field as a rank feature (negative), which will contribute negatively to a score if specified:

```json
PUT /wk77_fake2/_mapping
{
  "properties" : {
    "spam_score" : {
      "type" : "rank_feature",
      "positive_score_impact": false
    }
  }
}
```

# Load Data to the Second Index

You can use one of the methods here to reload data into the second index:
1. Use XLSX / CSV import to import the data;
2. Use the _reindex API

## Let's Use _reindex

Copy data from the first index to the second index:

```json
POST _reindex
{
  "source": {
    "index": "wk77_fake"
  },
  "dest": {
    "index": "wk77_fake2"
  }
}
```

In case there is any problem and you need to delete indexed data:

```json
POST /wk77_fake2/_delete_by_query
{
  "query": {
    "match_all": {}
  }
}
```

You may do the above to remove data and reindex them.

# Queries on the second index

## Query

Test this query on the **title** field.

Note this is using different similarities in the second index

```json
GET /wk77_fake2/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query":    "Votes",
      "fields": ["title"]
    }
  }
}
```

In what order are documents ranked?


## Query with Rank Features

Now try the same query with a **rank feature**:

```json
GET /wk77_fake2/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "title": "Votes"
          }
        }
      ],
      "should": {
        "rank_feature": {
          "field": "likes",
          "saturation": {
            "pivot": 5
          }
        }
      }
    }
  }
}
```

Is there any difference in the ranking?
