Message-Id: <5593CBB0-851B-45DF-AEAF-1E44FA921C50@cslab.ece.ntua.gr>
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
In-Reply-To: <91b3572a0806090821i6dcb918bob80c878a883ce23c@mail.gmail.com>
Content-Type: multipart/alternative; boundary=Apple-Mail-3-642154781
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [B.A.T.M.A.N.] question
Date: Mon, 9 Jun 2008 18:24:32 +0300
References: <91b3572a0806080640n274dbb4qe9abe4082cbebb3c@mail.gmail.com>
	<21DD4A18-C436-49CB-8B33-2729C10233AF@lo-res.org>
	<91b3572a0806081235t61b6b5f2g3e0d2a2200e9a702@mail.gmail.com>
	<C34B0738-A655-4003-8C19-0F2180B2607B@lo-res.org>
	<91b3572a0806090821i6dcb918bob80c878a883ce23c@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Apple-Mail-3-642154781
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

If this is an embedded device, like a Linksys WRT54G(L),
you should  be able to access the router in "failsafe" mode
in order to put the original settings back. Power cycle it and
press the reset button while it powers on.

More info:

http://wiki.openwrt.org/OpenWrtDocs/Troubleshooting

Regards,

Antony

On Jun 9, 2008, at 6:21 PM, Mathias HOUNGBO wrote:

> what can i do now ?
>
> reset the router
>
> 2008/6/8 Aaron Kaplan <aaron@lo-res.org>:
>
> On Jun 8, 2008, at 9:35 PM, Mathias HOUNGBO wrote:
>
> Hi Aaron,
>
> after put
>
> iptables -F
> iptables -t nat -F
>
> in my firewall.user
>
> It's impossible to access to the router :(
>
> oops! seems you do have a default deny route there.
>
>
>
>
> no ping, no ssh, no web interface
>
>
>
> 2008/6/8, Aaron Kaplan <aaron@lo-res.org>:
>
> On Jun 8, 2008, at 3:40 PM, Mathias HOUNGBO wrote:
>
> Hi everybody;
>
> Someone can provide an howto on batman + openwrt kamikaze + adhoc +
> firewall.user ?
>
>
> firewall.user:
>
>
> just have the iptables fulshed. Like this:
>
> iptables -F
> iptables -t nat -F
>
>
> thanks
>
>
> --
> Mathias HOUNGBO
> http://mathias.houngbo.net/ (mon blog)
> http://mathias.houngbo.net/wiki/ (mon wiki)
> http://www.cotonou-wireless.org (le wifi enchain=E9)
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> ---
> there's no place like 127.0.0.1
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
>
> -- =20
> Mathias HOUNGBO
> http://mathias.houngbo.net/ (mon blog)
> http://mathias.houngbo.net/wiki/ (mon wiki)
> http://www.cotonou-wireless.org (le wifi enchain=E9)
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> ---
> there's no place like 127.0.0.1
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
>
> -- =20
> Mathias HOUNGBO
> http://mathias.houngbo.net/ (mon blog)
> http://mathias.houngbo.net/wiki/ (mon wiki)
> http://www.cotonou-wireless.org (le wifi enchain=E9) =20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--Apple-Mail-3-642154781
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">If this is an embedded device, =
like a Linksys WRT54G(L),<div>you should &nbsp;be able to access the =
router in "failsafe" mode<div>in order to put the original settings =
back. Power cycle it and</div><div>press the reset button while it =
powers on.</div><div><br></div><div>More =
info:</div><div><br></div><div><a =
href=3D"http://wiki.openwrt.org/OpenWrtDocs/Troubleshooting">http://wiki.o=
penwrt.org/OpenWrtDocs/Troubleshooting</a><br><div><html><br></html><html>=
Regards,</html><html><br></html><html>Antony</html><html><br></html><html>=
On Jun 9, 2008, at 6:21 PM, Mathias HOUNGBO wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite">what can i =
do now ?<br><br>reset the router<br><br><div =
class=3D"gmail_quote">2008/6/8 Aaron Kaplan &lt;<a =
href=3D"mailto:aaron@lo-res.org">aaron@lo-res.org</a>>:<br><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> <div =
class=3D"Ih2E3d"><br> On Jun 8, 2008, at 9:35 PM, Mathias HOUNGBO =
wrote:<br> <br> <blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;"> Hi Aaron,<br> <br> after put<br> <br> iptables -F<br> iptables -t =
nat -F<br> <br> in my firewall.user<br> <br> It's impossible to access =
to the router :(<br> </blockquote> <br></div> oops! seems you do have a =
default deny route there.<div><div></div><div class=3D"Wj3C7c"><br> <br> =
<br> <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> <br> =
no ping, no ssh, no web interface<br> <br> <br> <br> 2008/6/8, Aaron =
Kaplan &lt;<a href=3D"mailto:aaron@lo-res.org" =
target=3D"_blank">aaron@lo-res.org</a>>:<br> <blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> <br> On Jun 8, =
2008, at 3:40 PM, Mathias HOUNGBO wrote:<br> <br> <blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> Hi everybody;<br> =
<br> Someone can provide an howto on batman + openwrt kamikaze + adhoc =
+<br> firewall.user ?<br> <br> </blockquote> <br> firewall.user:<br> =
<br> <br> just have the iptables fulshed. Like this:<br> <br> iptables =
-F<br> iptables -t nat -F<br> <br> <br> <blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;"> thanks<br> <br> <br> --<br> Mathias =
HOUNGBO<br> <a href=3D"http://mathias.houngbo.net/" =
target=3D"_blank">http://mathias.houngbo.net/</a> (mon blog)<br> <a =
href=3D"http://mathias.houngbo.net/wiki/" =
target=3D"_blank">http://mathias.houngbo.net/wiki/</a> (mon wiki)<br> <a =
href=3D"http://www.cotonou-wireless.org" =
target=3D"_blank">http://www.cotonou-wireless.org</a> (le wifi =
enchain=E9)<br> <br> _______________________________________________<br> =
B.A.T.M.A.N mailing list<br> <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" =
target=3D"_blank">B.A.T.M.A.N@open-mesh.net</a><br> <a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" =
target=3D"_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><b=
r> <br> </blockquote> <br> ---<br> there's no place like <a =
href=3D"http://127.0.0.1" target=3D"_blank">127.0.0.1</a><br> <br> <br> =
<br> <br> _______________________________________________<br> =
B.A.T.M.A.N mailing list<br> <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" =
target=3D"_blank">B.A.T.M.A.N@open-mesh.net</a><br> <a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" =
target=3D"_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><b=
r> <br> </blockquote> <br> <br> -- <br> Mathias HOUNGBO<br> <a =
href=3D"http://mathias.houngbo.net/" =
target=3D"_blank">http://mathias.houngbo.net/</a> (mon blog)<br> <a =
href=3D"http://mathias.houngbo.net/wiki/" =
target=3D"_blank">http://mathias.houngbo.net/wiki/</a> (mon wiki)<br> <a =
href=3D"http://www.cotonou-wireless.org" =
target=3D"_blank">http://www.cotonou-wireless.org</a> (le wifi =
enchain=E9)<br> <br> _______________________________________________<br> =
B.A.T.M.A.N mailing list<br> <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" =
target=3D"_blank">B.A.T.M.A.N@open-mesh.net</a><br> <a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" =
target=3D"_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><b=
r> <br> </blockquote> <br> ---<br> there's no place like <a =
href=3D"http://127.0.0.1" target=3D"_blank">127.0.0.1</a><br> <br> <br> =
<br> <br> _______________________________________________<br> =
B.A.T.M.A.N mailing list<br> <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" =
target=3D"_blank">B.A.T.M.A.N@open-mesh.net</a><br> <a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" =
target=3D"_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><b=
r> </div></div></blockquote></div><br><br clear=3D"all"><br>-- =
<br>Mathias HOUNGBO<br><a =
href=3D"http://mathias.houngbo.net/">http://mathias.houngbo.net/</a> =
(mon blog)<br><a =
href=3D"http://mathias.houngbo.net/wiki/">http://mathias.houngbo.net/wiki/=
</a> (mon wiki)<br> <a =
href=3D"http://www.cotonou-wireless.org">http://www.cotonou-wireless.org</=
a> (le wifi enchain=E9) =
_______________________________________________<br>B.A.T.M.A.N mailing =
list<br>B.A.T.M.A.N@open-mesh.net<br>https://list.open-mesh.net/mm/listinf=
o/b.a.t.m.a.n<br></blockquote></div><br></div></div></body></html>=

--Apple-Mail-3-642154781--
