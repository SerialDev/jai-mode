#import "Basic";
#import "Compiler";
#import "Math";
#import "Program_Print";
#import "String";

lesson_1 :: () {
    a_variable : float = 37.0;
    print("A is of type %, value %.\n", type_of(a_variable), a_variable);

}

lesson_2 :: () {
    a_variable: u8 = 10;
    b: u16 = 50;
    c: u32 = 0x78f;
    d: u64 = 0xfade_deaf_cafe_babe;

    e: s8 = -7;
    f: s16 = 0b101101101;
    g: s32 = -5_069_105;
    h: s64 = 98765432111;
    k := 7;

    b =cast(u16)c;

    /* a_variable = cast(u8) c; // Runtime error  */

    print("A is of type %, value %.\n", type_of(a_variable), a_variable);
    print("b is of type %, value %.\n", type_of(b), b);


    print("c is of type %, value %.\n", type_of(c), c);
    print("d is of type %, value %.\n", type_of(d), d);
    print("e is of type %, value %.\n", type_of(e), e);
    print("f is of type %, value %.\n", type_of(f), f);
    print("g is of type %, value %.\n", type_of(g), g);
    print("h is of type %, value %.\n", type_of(h), h);
    print("k is of type %, value %.\n", type_of(k), k);

    a_variable = cast,no_check(u8) c;
    // Cast bounds checks can be turned off at compile time,
    // for builds that you want to run at maximum speed.
    print("c is %; after casting this to u8, a is now %.\n", c, a_variable);


    my_int: int = 7;
    int_matching := type_of(my_int) == type_of(h);
    print("int_matching: %, %, % \n", int_matching, type_of(my_int), type_of(h));

    l: float32 = 123.005;
    m: float64 = 500.321;
    print("l is of type %, % bytes large.\n", type_of(l), size_of(type_of(l)));
    print("m is of type %, % bytes large.\n", type_of(m), size_of(type_of(m)));

    n := 1.111;
    o := 1.11111111111111111;

    print("n is %, of type %.\n", n, type_of(n));
    print("o is %, of type %.\n", o, type_of(o));  // Right now we don't print all the trailing digits of o, though.

    nan32 := 0h7fbf_ffff; // This is a NaN
    weird64 := 0h8000_0000_0000_0000; // Negative zero, 64-bit version

    print("nan32 is: % of type: % and size: %\n", nan32, type_of(nan32), size_of(type_of(nan32)));
    print("weird64 is: % of type: % and size: %\n", weird64, type_of(weird64), size_of(type_of(weird64)));

    // The type 'float' is an alias for float32.

    x: float32 = 111.0;
    y: float = x;

    float_matching := type_of(x) == type_of(y);
    print("float_matching: %\n", float_matching); // y and x are of the same type


}


lesson_3 :: () {

    x: bool;

    x = true;

    print("step 1: x is %\n", x);

    x = false;

    print("step 2: x is %\n", x);

    x = !x;

    print("step 3: x is %\n", x);


    if x {
	print("x was true, so the 'if' block on line %(%) % was executed.\n", #location(), type_of(#location()), #location().line_number);
    }



    // Of course, the compiler can infer the type of a bool just like anything else.

    y := false;
    print("type_of(y) is %\n", type_of(y));

    
    
    
    convert :: (arg: $T) {
        print("% (type %), cast to bool, is %\n", arg, type_of(arg), cast(bool) arg);
    }

    print("\n");

    // Now let's cast various things to bool and see the result.

    convert(0);
    convert(1);
    convert(cast(s16) -37);
    convert(69105.33);
    convert("Hello, Sailor!");

    print("\n");

    negative_zero_64 := 0h8000_0000_0000_0000; // Negative zero 64bit 

    convert(negative_zero_64);

    almost_negative_zero_64 := 0h8000_0000_0000_0001; // Negative zero, 64-bit version, with the low bit set.
    convert(almost_negative_zero_64);
    print("... (We didn't print out enough digits there. If we did, you'd see it's not really 0.)\n");

    if_check :: (arg: $T) {
	b:= cast(bool) arg;
	if arg {
	    print("b is: %. it had better be true \n", b);
	} else {
	    print("b is: %. it had better be false \n", b);
	}
    }

    if_check(0);
    if_check(1);
    if_check(cast(s16) -37);
    if_check(69105.33);
    if_check("Hello, Sailor!");
    if_check(negative_zero_64);
    if_check(almost_negative_zero_64);


    
}


lesson_4 :: () {
    print("\n");
    print("Part 1:\n\n");
    x: [8] int;

    print("x: %\n", x);
    z: [] int;
    print("z: %\n", z);

    x[3] = 9;
    x[4] = 16;
    x[5] = x[3] * x[4];

    print("x[5] is: %\n", x[5]);

    n := 37;

    /* y := x[n]; // out of bounds runtime error  */
    /* y := x[44]; */

    for index: 0..7 {
	print("x[%] ==  &%\n", index, x[index]);
    }
    
    print("\n");

    my_string: [5] string;

    my_string[1] = "frooty";
    my_string[3] = "loopy";
    my_string[2] = "adgfagagag";
    my_string[4] = "gondar";

    print("my_string: %\n",my_string);

    for s, i: my_string {
	print("my_string[%] is : '%'\n", i,s);
    }
    print("\n");
    print("Part 2:\n\n");

    a: [8] float;
    b: [9] float;

    print("type_of(a) is %.\n", type_of(a));
    print("type_of(b) is %.\n", type_of(b));
    print("dim(b) is %.\n", b.count);

    print("type_of(a) == type_of(b): %.\n", type_of(a) == type_of(b));

    c: [] float;
    for i: 0..7 a[i] = cast(float) i;  // Fill a with some data.
    c = a;    // c is now a view on a;
    print("c is: %\n", c);
    /* c[9] = 9;     // Uncomment this for a runtime error. */
    
    print("a is % bytes large.\n", size_of(type_of(a)));
    print("c is % bytes large.\n", size_of(type_of(c)));

    print("\n");

    print_sum :: (name:string, array: [] float) {
	sum: float;
	for value: array sum+= value;

	print("the sum of elements in '%' is : %\n", name, sum);
    }

    print_sum("a", a);
    print_sum("b", b);
    print_sum("c", c);

    for value, index: c {  
        print("c[%] == %\n", index, value);
    }
    print("\n");
    print("\n");

    c.count = 5;

    for value, index: c {  // Our iteration will only go from 0..4, since we set the count to 5.
        print("c[%] == %\n", index, value);
    }

    print("before writing to c, a[1] == %\n", a[1]);
    c[1] = 42;
    print("after writing to c, a[1] == %\n", a[1]);

    print("\n");
    print("Before pointer bump:\n");
    for value, index: c  print("c[%] == %\n", index, value);

    c.data += 1;  // Increment the data pointer by 1 slot (4 bytes in this case).
    print("\n");
    print("After pointer bump:\n");
    for value, index: c  print("c[%] == %\n", index, value);

    print("\n");
    print("\n");

    {
    a: [..] int;
    for 1..10 array_add(*a, it);  // Just fill a with some values.

    for value, index: a  print("a[%] == %\n", index, value);
    print("\n");

    v: [] int = a;  // Make a view onto a.
    for 1..10 array_add(*a, it);  // Add more stuff to a.
    for value, index: a  print("a[%] == %\n", index, value);
    if false {
        for v print("%\n", it);       // <------- This is BAD, since 'a' moved!
        }	
    }

    
}


lesson_4_1 :: () {
    resizable: [..] int;   // Declare a resizable array.
    print("resizable.count == %\n", resizable.count);
    print("resizable.data == %\n", resizable.data);
    array_add(*resizable, 1);
    array_add(*resizable, 4);
    array_add(*resizable, 9);
    array_add(*resizable, 16);
    for value, index: resizable print("idx:% val:% \n", index, value);
    print("resizable.count == %\n", resizable.count);
    print("resizable.data == %\n", resizable.data);
    print("Elements of 'resizable' are:");
    for resizable print(" % ", it);
    print("\n");

    f :: (array: [] int) {
        for array print("array[%] is %.\n", it_index, it);
    }
    print("\n");
    print("Resizable:\n");
    f(resizable);  // Call f with the resizable array.

    fixed: [3] int;  // A FiXED array, as covered in part 1!
    fixed[0] = 99;
    fixed[1] = 88;
    fixed[2] = 77;

    print("\n");
    print("Fixed:\n");
    f(fixed);      // Call f with the fixed array.
    
    print("\n");
    print("% % % % %\n", resizable.count, resizable.data, resizable.allocated, resizable.allocator, resizable.allocator_data);


    pointer_a: *[..] int = *resizable;
    print("pointer_a.count is %; pointer_a.data is %.\n", pointer_a.count, pointer_a.data);

    // pointer_b will give the same results as pointer_a!
    pointer_b: *[] int   = *resizable;
    print("pointer_b.count is %; pointer_b.data is %.\n", pointer_b.count, pointer_b.data);


    // FIXED arrays, which hold all memory for the elements and nothing else:
    fixed_array: [20] int;

    // Array VIEWS, which always point at data held somewhere else:
    array_view: [] int = fixed_array;

    print("array_view.count == %\n", array_view.count);
    print("array_view[10]   == %\n", array_view[10]);  // This will be zero, since fixed_array is initialized to zero.
    

    // RESIZABLE arrays, which dynamically allocate memory as they grow:
    resizable_array: [..] int;
    array_add(*resizable_array, 42);             // Causes the array to grow.

    print("Part 1, resizable_array.count == %; resizable_array.allocated == %.\n", resizable_array.count, resizable_array.allocated);
    print("        resizable_array.data == %.\n", resizable_array.data);
    for 1..100 array_add(*resizable_array, it);  // Causes the array to grow a fair bit more!

    print("Part 2, resizable_array.count == %; resizable_array.allocated == %.\n", resizable_array.count, resizable_array.allocated);
    print("        resizable_array.data == %.\n", resizable_array.data);  // This will be different from the previous value we printed!

    array_view = resizable_array;  // Pointing array_view at a new place!
    print("array_view.count == %\n", array_view.count);
    print("array_view[10]   == %\n", array_view[10]);    
}

lesson_5 :: () {
    print("\n");
    print("Part 1:\n\n");
    x: string;

    x = "Hello";
    print("x is: '%'.\n", x);
    
    x = "Sailor";

    print("x is: '%'.\n", x);
    print("x[5] is: %\n", x[5]);
    /* print("x[6] is: %\n", x[6]); // Strings are bounds-checked! */
    
    x.count = 4;
    print("x is: '%'\n", x);    // x is now "Sail".


    x.count -= 1;
    x.data += 1;
    print("x is: '%'\n", x);    // x is now "ail".

    /* for x { print("hi\n"); }    // This doesn't work. */


    print("\n");
    print("type_of(x)          is: %\n", type_of(x));
    print("size_of(type_of(x)) is: %\n", size_of(type_of(x)));
    print("\n");
    print("type_of(x[1])    is: %\n", type_of(x[1]));
    print("type_of(x.count) is: %\n", type_of(x.count));
    print("type_of(x.data)  is: %\n", type_of(x.data));

    // start part 2
/* data drift and concept drift  */


}


array_slice :: (array: *[] $T, l: int = 0, r: int = 0) -> [] T {
    array_view: [] T = <<array;
    print("\n(%) *(%)\n", array_view, array);
    array_view.data += l;
    array_view.count -= l;
    print("\n(%) *(%)\n", array_view, array);
    return array_view;
}

main :: () {

    /* print("\nlesson 1: \n"); */
    /* lesson_1(); */
    /* print("\nlesson 2: \n"); */
     /* lesson_2(); */
    /* print("\nlesson 3: \n"); */
    /* lesson_3(); */
    /* print("\nlesson 4: \n"); */
    /* lesson_4(); */
    /* lesson_4_1(); */
    /* print("\nlesson 4: \n"); */
    /* lesson_5(); */

    x : [..] int;
    for 1..10 array_add(*x, it);  // Just fill a with some values.

    /* print("\n(%) *(%)\n", x, *x); */

    print("\n%\n", x.count);
    a := array_slice(*x, 8);
    print("array_slice: %", a);
    print("\n%\n", x.count);
    b := array_slice(*x, 2);
    print("array_slice: %", b);
    x[9] = 11;
    print("array_slice: %", b);
    print("\n%\n", x.count);
    print("array_slice: %", a);
    print("\n%\n", x.count);
    print("array_slice: %\n", array_slice(*x));

    print("\n%\n", x);
    b[0] =32;
    print("\nx:%\n", x);
    print("\na:%\n", a);
    a[1] = 19 ;
    print("\nx: %\n", x);
    print("\nb: %\n", b);

    print("\nb: %\n", #location(b));
    /* code := #code x; */

/* #run { */
/*     builder: String_Builder; */
/*     code :: #code aa := Vector3.{1, 1, 1}; */
/*     root, expressions := compiler_get_nodes(code); */
/*     print_expression(*builder, root); */
/*     loc := #location(code); */
/*     print("The code at %:% was:\n", loc.fully_pathed_filename, loc.line_number); */


/* } */







    /* x: [..] int; */
    /* for 1..10 array_add(*a, it);  // Just fill a with some values. */



}











