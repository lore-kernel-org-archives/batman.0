Message-Id: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
Content-Type: multipart/alternative; boundary=Apple-Mail-5--72783900
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 7 May 2008 15:17:29 +0300
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


--Apple-Mail-5--72783900
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi all.

I have made a new version of the patch posted by acinonyx (rv502),
for interfacing batmand with the zebra routing daemon. There are 2
versions available: One for the latest svn (rv1060) and one for the
stable 0.3 release. Take a look at:

http://www.cslab.ece.ntua.gr/~chazapis/batman/

Please consider this code experimental. Some initial tests are  
promising,
but there may be bugs... :)

For now, the plug-in just supports sending routes to zebra, not the
opposite (redistributing routes from other protocols). That was also
the case with the older - rv502 - version.

What the patch does is:
- Adds a flag "-z" to the batmand executable which may be used to
   enable zebra communication and accepts as an argument the
   path to the corresponding zebra unix-domain socket.
- If zebra is enabled:
   - No rules are added to the kernel.
   - All UNICAST routes are sent to zebra.

All routes are also sent to the kernel (in linux/route.c), but the extra
routing tables are not used by linux, because of the lack of rules.
These routing tables remain, just to help with route management,
so batmand can successfully remove all added routes on shutdown.

Antony

--Apple-Mail-5--72783900
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; ">Hi all.<br><br>I have made a new version of the =
patch posted by acinonyx (rv502),<br>for interfacing batmand with the =
zebra routing daemon. There are 2<br>versions available: One for the =
latest svn (rv1060) and one for the<br>stable 0.3 release. Take a look =
at:<br><br><a =
href=3D"http://www.cslab.ece.ntua.gr/~chazapis/batman/">http://www.cslab.e=
ce.ntua.gr/~chazapis/batman/</a><br><br>Please consider this code =
experimental. Some initial tests are promising,<br>but there may be =
bugs... :)<div><br></div><div>For now, the plug-in just supports sending =
routes to zebra, not the</div><div>opposite (redistributing routes from =
other protocols). That was also</div><div>the case with the older - =
rv502 - version.</div><div><br></div><div>What the patch does =
is:</div><div>- Adds a flag "-z" to the batmand executable which may be =
used to</div><div>&nbsp;&nbsp;enable zebra communication and accepts as =
an argument the</div><div>&nbsp;&nbsp;path to the corresponding =
zebra&nbsp;unix-domain socket.</div><div>- If zebra is =
enabled:</div><div>&nbsp;&nbsp;- No rules are added to the =
kernel.</div><div>&nbsp;&nbsp;- All UNICAST routes are sent to =
zebra.</div><div><br></div><div>All routes are also sent to the kernel =
(in linux/route.c), but the extra</div><div>routing tables are not used =
by linux, because of the lack of rules.</div><div>These routing tables =
remain, just to help with route management,</div><div>so batmand can =
successfully remove all added routes on =
shutdown.</div><div><br>Antony<br></div></div></body></html>=

--Apple-Mail-5--72783900--
