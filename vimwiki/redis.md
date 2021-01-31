Redis
=====
* **SET**
* GET
* EXISTS
* INCR
* INCRBY
* DECR
* DECRBY
* **EXPIRE**
* **TTL**: The -2 for the TTL of the key means that the key does not exist
  (anymore). A -1 for the TTL of the key means that it will never expire. Note
  that if you SET a key, its TTL will be reset.
* PERSIST
* **lists**: RPUSH, LPUSH, LLEN, LRANGE, LPOP, RPOP
* **sets**: SADD, SREM, SISMEMBER, SMEMBERS, SUNION
* **sorted sets**
* **hashes**

----------------------
``` redis
SET resource:lock "Redis Demo 3" EX 5
PERSIST resource:lock
LRANGE friends 0 -1
RPUSH friends 1 2 3 => 4
```
------------------------

There is something special about **INCR**. Why do we provide such an operation if
we can do it ourself with a bit of code? After all it is as simple as:

``` redis
x = GET count
x = x + 1
SET count x
```

The problem is that doing the increment in this way will only work as long as
there is a single client using the key. See what happens if two clients are
accessing this key at the same time:

  1. Client A reads count as 10.
  1. Client B reads count as 10.
  1. Client A increments 10 and sets count to 11.
  1. Client B increments 10 and sets count to 11.

We wanted the value to be 12, but instead it is 11! This is because
incrementing the value in this way is not an atomic operation. Calling the **INCR**
command in Redis will prevent this from happening, because it is an atomic
operation.

All the Redis operations implemented by single commands are atomic, including
the ones operating on more complex data structures. So when you use a Redis
command that modifies some value, you don't have to think about concurrent
access.
