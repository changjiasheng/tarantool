#ifndef TARANTOOL_BOX_TUPLE_COMPARE_H_INCLUDED
#define TARANTOOL_BOX_TUPLE_COMPARE_H_INCLUDED
/*
 * Copyright 2010-2016, Tarantool AUTHORS, please see AUTHORS file.
 *
 * Redistribution and use in source and binary forms, with or
 * without modification, are permitted provided that the following
 * conditions are met:
 *
 * 1. Redistributions of source code must retain the above
 *    copyright notice, this list of conditions and the
 *    following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials
 *    provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * <COPYRIGHT HOLDER> OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
 * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#include "key_def.h"

#if defined(__cplusplus)
extern "C" {
#endif /* defined(__cplusplus) */

struct tuple;

/**
 * Create a comparison function for the key_def
 *
 * @param key_def key_definition
 * @returns a comparision function
 */
tuple_compare_t
tuple_compare_create(const struct key_def *key_def);

/**
 * @copydoc tuple_compare_create()
 */
tuple_compare_with_key_t
tuple_compare_with_key_create(const struct key_def *key_def);

/**
 * Compare keys using the key definition.
 * @param key_a key parts without MessagePack array header
 * @param part_count_a the number of parts in the key_a
 * @param key_b key_parts without MessagePack array header
 * @param part_count_b the number of parts in the key_b
 * @param key_def key definition
 *
 * @retval 0  if key_a == key_b
 * @retval <0 if key_a < key_b
 * @retval >0 if key_a > key_b
 */
int
key_compare(const char *key_a, uint32_t part_count_a,
	    const char *key_b, uint32_t part_count_b,
	    const struct key_def *key_def);

/**
 * Compare tuples using the key definition.
 * @param tuple_a first tuple
 * @param tuple_b second tuple
 * @param key_def key definition
 * @retval 0  if key_fields(tuple_a) == key_fields(tuple_b)
 * @retval <0 if key_fields(tuple_a) < key_fields(tuple_b)
 * @retval >0 if key_fields(tuple_a) > key_fields(tuple_b)
 */
static inline int
tuple_compare(const struct tuple *tuple_a, const struct tuple *tuple_b,
	      const struct key_def *key_def)
{
	return key_def->tuple_compare(tuple_a, tuple_b, key_def);
}

/**
 * @brief Compare tuple with key using the key definition.
 * @param tuple tuple
 * @param key key parts without MessagePack array header
 * @param part_count the number of parts in @a key
 * @param key_def key definition
 *
 * @retval 0  if key_fields(tuple) == parts(key)
 * @retval <0 if key_fields(tuple) < parts(key)
 * @retval >0 if key_fields(tuple) > parts(key)
 */
static inline int
tuple_compare_with_key(const struct tuple *tuple, const char *key,
		       uint32_t part_count, const struct key_def *key_def)
{
	return key_def->tuple_compare_with_key(tuple, key, part_count,
					       key_def);
}

#if defined(__cplusplus)
} /* extern "C" */
#endif /* defined(__cplusplus) */

#endif /* TARANTOOL_BOX_TUPLE_COMPARE_H_INCLUDED */
