# -*- coding: utf-8 -*-

# システム管理アカウントの追加
admin_profile = Profile.new(nick_name: "Administrator",
                            locale: "ja")

admin = User.create(login: "admin",
                    email: "admin@localhost.local",
                    password: "monkey",
                    password_confirmation: "monkey",
                    profile: admin_profile)
