---
title: Guava 源码阅读系列——Primitives Ints 类
date: 2022-03-03 20:15:50
categories: ["源码阅读", "Guava"]
toc: true
tags:
- Guava
---

`Ints` 类作为 Guava 对 Java 基本数据类型 `int` 的工具类封装。

<!-- more -->

## 常量

###  `BYTES` 

```Java
//在 Java 8 中可以被 Integer.BYTES 替代，代表字节数 bytes
public static final int BYTES = Integer.SIZE / Byte.SIZE;
```

### `MAX_POWER_OF_TWO`

```Java
// int 最大存储值，使用 1<<(Integer.SIZE-2) 计算得到，2是因为一位代表正负，1同时占一位
public static final int MAX_POWER_OF_TWO = 1 << (Integer.SIZE - 2);
```

## 静态方法

### `public static int hasCode(int)`

计算传入 int 值的 hashcode。与 JDK 8 中 `Integer.hashCode(int)` 一样，直接返回数值本身。

```Java
public static int hashCode(int value) {
  return value;
}
```

### `public static int checkedCast(long)`

将 long 强制类型转换为 int。
当传入参数超出 int 的取值范围 [2^31-1, -2^31] 时，抛出 `IllegalArgumentException` 异常，否则返回参数本身。

```Java
public static int checkedCast(long value) {
  int result = (int) value;
  checkArgument(result == value, "Out of range: %s", value);
  return result;
}
```

### `public static int saturatedCast(long)`

将 long 转换成 int 范围内的值。
与 `checkedCast` 不同的是，当传入参数大于 int 最大值或小于 int 最小值，直接返回最大值或最大值，而不是抛异常。

```java
public static int saturatedCast(long value) {
  if (value > Integer.MAX_VALUE) {
    return Integer.MAX_VALUE;
  }
  if (value < Integer.MIN_VALUE) {
    return Integer.MIN_VALUE;
  }
  return (int) value;
}
```

### `public static int compare(int, int)`

比较两个 int 值的大小，等价于 `((Integer) a).compareTo(b)`。返回值分为三种情况: a 小于/等于/大于 b 时分别返回 -1/0/1。
注：JDK 7 及以后建议使用 `Integer.compar(int, int)` 而非此方法。

```Java
public static int compare(int a, int b) {
  return (a < b) ? -1 : ((a > b) ? 1 : 0);
}
```

### `public static boolean contains(int[], int)`

```Java
public static boolean contains(int[] array, int target) {
  for (int value : array) {
    if (value == target) {
      return true;
    }
  }
  return false;
}
```

### `public static int indexOf(int[], int)`

```Java
public static int indexOf(int[] array, int target) {
  return indexOf(array, target, 0, array.length);
}
```

### `private static int indexOf(int[], int, int, int)`

```Java
private static int indexOf(int[] array, int target, int start, int end) {
  for (int i = start; i < end; i++) {
    if (array[i] == target) {
      return i;
    }
  }
  return -1;
}
```

### `public static int indexOf(int[], int[])`

```Java
public static int indexOf(int[] array, int[] target) {
  checkNotNull(array, "array");
  checkNotNull(target, "target");
  if (target.length == 0) {
    return 0;
  }

  outer:
  for (int i = 0; i < array.length - target.length + 1; i++) {
    for (int j = 0; j < target.length; j++) {
      if (array[i + j] != target[j]) {
        continue outer;
      }
    }
    return i;
  }
  return -1;
}
```

### `public int lastIndexOf(int[], int)`

```Java
public static int lastIndexOf(int[] array, int target) {
  return lastIndexOf(array, target, 0, array.length);
}
```

### `private int lastIndexOf(int[], int, int, int)`

```Java
private static int lastIndexOf(int[] array, int target, int start, int end) {
  for (int i = end - 1; i >= start; i--) {
    if (array[i] == target) {
      return i;
    }
  }
  return -1;
}
```

### `public static int min(int...)`

```Java
public static int min(int... array) {
  checkArgument(array.length > 0);
  int min = array[0];
  for (int i = 1; i < array.length; i++) {
    if (array[i] < min) {
      min = array[i];
    }
  }
  return min;
}
```

### `public static int max(int...)`

```Java
public static int max(int... array) {
  checkArgument(array.length > 0);
  int max = array[0];
  for (int i = 1; i < array.length; i++) {
    if (array[i] > max) {
      max = array[i];
    }
  }
  return max;
}
```

### `public static int constrainToRange(int, int, int)`

```Java
public static int constrainToRange(int value, int min, int max) {
  checkArgument(min <= max, "min (%s) must be less than or equal to max (%s)", min, max);
  return Math.min(Math.max(value, min), max);
}
```

### `public static int[] concat(int[]...)`

```Java
public static int[] concat(int[]... arrays) {
  int length = 0;
  for (int[] array : arrays) {
    length += array.length;
  }
  int[] result = new int[length];
  int pos = 0;
  for (int[] array : arrays) {
    System.arraycopy(array, 0, result, pos, array.length);
    pos += array.length;
  }
  return result;
}
```

### `public static byte[] toByteArray(int)`

```Java
public static byte[] toByteArray(int value) {
  return new byte[] {
    (byte) (value >> 24), (byte) (value >> 16), (byte) (value >> 8), (byte) value
  };
}
```

### `public static int fromByteArray(byte[])`

```Java
public static int fromByteArray(byte[] bytes) {
  checkArgument(bytes.length >= BYTES, "array too small: %s < %s", bytes.length, BYTES);
  return fromBytes(bytes[0], bytes[1], bytes[2], bytes[3]);
}
```

### `public static int fromBytes(byte, byte, byte, byte)`

```Java
public static int fromBytes(byte b1, byte b2, byte b3, byte b4) {
  return b1 << 24 | (b2 & 0xFF) << 16 | (b3 & 0xFF) << 8 | (b4 & 0xFF);
}
```

### `public static Converter<String, Integer> stringConverter()`

```Java
public static Converter<String, Integer> stringConverter() {
  return IntConverter.INSTANCE;
}
```

### `public static int[] ensureCapacity(int[], int, int)`

```Java
public static int[] ensureCapacity(int[] array, int minLength, int padding) {
  checkArgument(minLength >= 0, "Invalid minLength: %s", minLength);
  checkArgument(padding >= 0, "Invalid padding: %s", padding);
  return (array.length < minLength) ? Arrays.copyOf(array, minLength + padding) : array;
}
```

### `public static String join(String, int...)`

```Java
public static String join(String separator, int... array) {
  checkNotNull(separator);
  if (array.length == 0) {
    return "";
  }

  // For pre-sizing a builder, just get the right order of magnitude
  StringBuilder builder = new StringBuilder(array.length * 5);
  builder.append(array[0]);
  for (int i = 1; i < array.length; i++) {
    builder.append(separator).append(array[i]);
  }
  return builder.toString();
}
```

### `public static void sortDescending(int[])`

```Java
/**
  * Sorts the elements of {@code array} in descending order.
  *
  * @since 23.1
  */
public static void sortDescending(int[] array) {
  checkNotNull(array);
  sortDescending(array, 0, array.length);
}
```

### `public static void sortDescending(int[], int, int)`

```Java
public static void sortDescending(int[] array, int fromIndex, int toIndex) {
  checkNotNull(array);
  checkPositionIndexes(fromIndex, toIndex, array.length);
  Arrays.sort(array, fromIndex, toIndex);
  reverse(array, fromIndex, toIndex);
}
```

### `public static void reverse(int[])`

```Java
public static void reverse(int[] array) {
  checkNotNull(array);
  reverse(array, 0, array.length);
}
```

### `public static void reverse(int[], int, int)`

```Java
public static void reverse(int[] array, int fromIndex, int toIndex) {
  checkNotNull(array);
  checkPositionIndexes(fromIndex, toIndex, array.length);
  for (int i = fromIndex, j = toIndex - 1; i < j; i++, j--) {
    int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;
  }
}
```

### `public static int[] toArray(Collection<? extends Number>)`

```Java
public static int[] toArray(Collection<? extends Number> collection) {
  if (collection instanceof IntArrayAsList) {
    return ((IntArrayAsList) collection).toIntArray();
  }

  Object[] boxedArray = collection.toArray();
  int len = boxedArray.length;
  int[] array = new int[len];
  for (int i = 0; i < len; i++) {
    // checkNotNull for GWT (do not optimize)
    array[i] = ((Number) checkNotNull(boxedArray[i])).intValue();
  }
  return array;
}
```

### `public static List<Integer> asList(int...)`

```Java
public static List<Integer> asList(int... backingArray) {
  if (backingArray.length == 0) {
    return Collections.emptyList();
  }
  return new IntArrayAsList(backingArray);
}
```

### `public static Integer tryParse(String)`

```Java
public static Integer tryParse(String string) {
  return tryParse(string, 10);
}
```

### `public static Integer tryParse(String, int)`

```Java
public static Integer tryParse(String string, int radix) {
  Long result = Longs.tryParse(string, radix);
  if (result == null || result.longValue() != result.intValue()) {
    return null;
  } else {
    return result.intValue();
  }
}
```

## 静态内部类

### `class IntConverter extends Converter<String, Integer> implements Serializable`

### `enum LexicographicalComparator implements Comparator<int[]>`

### `class IntArrayAsList extends AbstractList<Integer>implements RandomAccess, Serializable`
