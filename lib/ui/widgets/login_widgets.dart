import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

Widget buildEmailTextField(TextEditingController ctrl, bool registered) =>
    TextFormField(
        validator: (value) => EmailValidator.validate(value!)
            ? null : 'Enter a valid e-mail',
        maxLines: 1,
        controller: ctrl,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: const Icon(Icons.email_outlined),
          hintText: 'Your e-mail...',
        ),
    );

Widget buildPasswordTextField(TextEditingController ctrl, String text) =>
    TextFormField(
        maxLines: 1,
        controller: ctrl,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: const Icon(Icons.lock_outline),
          hintText: text,
        ),
        validator: (value) => value!.length < 6
        ? 'Password must contain at least 6 characters' : null,
    );