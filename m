Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <52941BED.9070402@altermundi.net>
Date: Tue, 26 Nov 2013 00:56:29 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <525B11F2.5030605@altermundi.net>
 <5282A184.1020704@altermundi.net> <20131112215442.GN3713@neomailbox.net>
 <5282CE44.8000402@altermundi.net> <20131113080404.GO886@medion.lan>
 <20131113080157.GO3713@neomailbox.net>
In-Reply-To: <20131113080157.GO3713@neomailbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] mad mad batman ...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El 13/11/13 05:01, Antonio Quartulli escribió:
> On Wed, Nov 13, 2013 at 09:04:05AM +0100, Bastian Bittorf wrote:
>> * Nicolás Echániz <nicoechaniz@altermundi.net> [13.11.2013
>> 08:59]:
>>> Am I the only one who has bumped into this (twice)?
>> 
>> I have also seen a lot of these messages with an indoor mesh, so
>> no lightning involved 8-) but with v2013.04 this is gone. (same
>> network).
> 
> this message is the symptom of a loop. The causes can be
> gazillions.

Well... it took about a week to finally find the node creating this
problem. As before, it's failing hardware that caused the issue.

When this happens every node in the net is repeatedly showing that
message. It is not the same with any "loop symptom" I believe... At
least I've never seen this happen on every node being caused by
something else.

I really would like to find out more about how this condition comes to
happen and how to diagnose and prevent it. The whole batman-adv cloud
dies when this happens and it's a pain in the ass to "debug".

All the failing routers are WR842ND. There are many more of the same
model working just fine.


I now have three routers which produce this symptom, so if anyone who
can understand the problem better is willing to test, I can set up a
dedicated mini-test-bed.


Cheers,
NicoEchániz



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iQEcBAEBAgAGBQJSlBvtAAoJEPHORz17N0TFf+sH/jC2qGbx3SpHZSNGgUoQrD/f
J9n+lUMugbsM7uOodBnU+iiswpOrNVn4NsddWNYXFmydpbIbnO6wuUTlDZu3wNig
gOMNDZqaze5fcdopwgcEuxvp1S5QRiAe2DN+ci0jQ3OGdOjuZgZJjpRxARDbSExT
guF4TgB4izZUy5/5OTg4pJdNZ8zUsMap45Gy4xzslP58EZUBKkeqol+kaWuiq4eX
FbUpezTpeTXlUi401pOzvrVMg7/JXhN7JULMgjPPR6y8359tfZFFQq4JwuYNSwz1
Fg6L3/kJSKm4DF7MyYa2Id/3DJx7NLZk1B7RQR05ISmuvGLDBqobqv6EY5a+Z0M=
=0BD+
-----END PGP SIGNATURE-----
