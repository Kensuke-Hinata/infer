% Copyright (c) Facebook, Inc. and its affiliates.
%
% This source code is licensed under the MIT license found in the
% LICENSE file in the root directory of this source tree.

-module(records).

-record(person, {name, phone, address}).
-record(rabbit, {name, color}).

-export([
    test_type_Ok/0,
    test_type_Bad/0,
    test_index1_Ok/0,
    test_index2_Ok/0,
    test_index3_Bad/0,
    test_index4_Bad/0,
    test_match_field2_Ok/0,
    test_match_field2_Bad/0,
    test_match_field3_Ok/0,
    test_match_field3_Bad/0,
    test_match_field4_Ok/0,
    test_match_field4_Bad/0,
    test_match_field_multiple1_Ok/0,
    test_match_field_multiple2_Bad/0,
    test_match_field_multiple3_Bad/0,
    test_match_as_tuple1_Ok/0,
    test_match_as_tuple2_Bad/0,
    test_match_as_tuple3_Bad/0,
    test_match_as_tuple4_Bad/0,
    test_match_as_tuple5_Bad/0
]).

accepts_rabbits(#rabbit{}) -> ok.

test_type_Ok() ->
    accepts_rabbits(#rabbit{name = "bunny", color = "brown"}).

test_type_Bad() ->
    accepts_rabbits(#person{name = "alice", phone = 123, address = "LON"}).

accepts_three_using_rabbit(#rabbit.color) -> ok.

accepts_four_using_person(#person.address) -> ok.

test_index1_Ok() ->
    accepts_three_using_rabbit(3).

test_index2_Ok() ->
    accepts_four_using_person(4).

test_index3_Bad() ->
    accepts_three_using_rabbit(2).

test_index4_Bad() ->
    accepts_four_using_person(5).

test_match_field2_Ok() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{name = 123} -> ok
    end.

test_match_field2_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{name = 9999999} -> ok
    end.

test_match_field3_Ok() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{phone = 45} -> ok
    end.

test_match_field3_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{phone = 9999999} -> ok
    end.

test_match_field4_Ok() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{address = 6789} -> ok
    end.

test_match_field4_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{address = 9999999} -> ok
    end.

test_match_field_multiple1_Ok() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{address = 6789, name = 123} -> ok
    end.

test_match_field_multiple2_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{address = 999999, name = 123} -> ok
    end.

test_match_field_multiple3_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        #person{address = 6789, name = 99999} -> ok
    end.

test_match_as_tuple1_Ok() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        {person, 123, 45, 6789} -> ok
    end.

test_match_as_tuple2_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        {rabbit, 123, 45, 6789} -> ok
    end.

test_match_as_tuple3_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        {person, 999999, 45, 6789} -> ok
    end.

test_match_as_tuple4_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        {person, 123, 999999, 6789} -> ok
    end.

test_match_as_tuple5_Bad() ->
    P = #person{name = 123, phone = 45, address = 6789},
    case P of
        {person, 123, 45, 999999} -> ok
    end.