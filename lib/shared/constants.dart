import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(

    fillColor: Colors.white,
    filled: true,

    enabledBorder: const OutlineInputBorder(

        borderRadius:  BorderRadius.all(

    const Radius.circular(40.0),
),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)
    )
);