Message-Id: <24746087-FB92-43A7-8DFB-7CAC7887AAA5@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200905061518.05597.lindner_marek@yahoo.de>
Content-Type: multipart/alternative; boundary=Apple-Mail-70--844190227
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 6 May 2009 11:51:38 +0200
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<200905061315.09151.lindner_marek@yahoo.de>
	<08B01611-F186-4533-9CC2-AA16BF92FEF7@7degrees.co.za>
	<200905061518.05597.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Apple-Mail-70--844190227
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable


On 06 May 2009, at 09:18 , Marek Lindner wrote:

> On Wednesday 06 May 2009 13:48:03 Antoine van Gelder wrote:
>>  http://code.google.com/p/afrimesh/
>>
>> The project is very young and still under heavy development but it
>> does have working code using client-side Javascript & the
>> OpenStreetMap libraries to draw mesh maps from the vis server.
>
> Very nice project!
> I think it would be a good idea to add a link and a short project =20
> description
> on open-mesh.net to point people to your project. What do you think ?


Tx Marek, yes please!



>>  2) I've patched the layer-3 vis daemon with a command-line
>>     option to output the mesh map in JSON format rather than
>>     dot as I found it a tad more amenable to abuse. (Btw, is
>>     this something anyone else would find useful? I'd be happy
>>     to clean up & contribute the patch!)
>
> Yes, I'm interested.  :-)
> JSON sounds like a good alternative to dot draw. If you bring your =20
> patch into
> shape I will commit it. May be you add an option to switch between =20
> dot draw
> and JSON ?


-j turns on JSON output and closes the socket after serving the =20
browser request.

Speaking of... If I were to run two vis daemons on the mesh would they =20=

synchronize with each other so that - in theory - one of them could =20
serve dot format and the other JSON ?

Patch to follow :)

- antoine



--
http://7degrees.co.za
"Libr=E9 software for human education."


--Apple-Mail-70--844190227
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><br>On 06 May 2009, at 09:18 , =
Marek Lindner wrote:<br><br><blockquote type=3D"cite">On Wednesday 06 =
May 2009 13:48:03 Antoine van Gelder wrote:<br></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"> &nbsp;<a =
href=3D"http://code.google.com/p/afrimesh/">http://code.google.com/p/afrim=
esh/</a><br></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite">The project is very young and =
still under heavy development but =
it<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite">does have working code using client-side Javascript &amp; =
the<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite">OpenStreetMap libraries to draw mesh maps from the vis =
server.<br></blockquote></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Very nice =
project!<br></blockquote><blockquote type=3D"cite">I think it would be a =
good idea to add a link and a short project =
description<br></blockquote><blockquote type=3D"cite">on open-mesh.net =
to point people to your project. What do you think =
?<br></blockquote><br><br>Tx Marek, yes =
please!<br><br><br><br><blockquote type=3D"cite"><blockquote =
type=3D"cite"> &nbsp;2) I've patched the layer-3 vis daemon with a =
command-line<br></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"> &nbsp;&nbsp;&nbsp;&nbsp;option =
to output the mesh map in JSON format rather =
than<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite"> &nbsp;&nbsp;&nbsp;&nbsp;dot as I found it a tad more =
amenable to abuse. (Btw, is<br></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"> &nbsp;&nbsp;&nbsp;&nbsp;this =
something anyone else would find useful? I'd be =
happy<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite"> &nbsp;&nbsp;&nbsp;&nbsp;to clean up &amp; contribute the =
patch!)<br></blockquote></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Yes, I'm =
interested. &nbsp;:-)<br></blockquote><blockquote type=3D"cite">JSON =
sounds like a good alternative to dot draw. If you bring your patch =
into<br></blockquote><blockquote type=3D"cite">shape I will commit it. =
May be you add an option to switch between dot =
draw<br></blockquote><blockquote type=3D"cite">and JSON =
?<br></blockquote><br><br> -j turns on JSON output and closes the socket =
after serving the browser request.<br><br>Speaking of... If I were to =
run two vis daemons on the mesh would they synchronize with each other =
so that - in theory - one of them could serve dot format and the other =
JSON ?<br><br>Patch to follow :)<br><br> - antoine<br><br><br><div =
apple-content-edited=3D"true"> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div><br =
class=3D"Apple-interchange-newline">--</div><div><a =
href=3D"http://7degrees.co.za">http://7degrees.co.za</a></div><div><div>"L=
ibr=E9 software for human education."</div></div></span> =
</div><br></body></html>=

--Apple-Mail-70--844190227--
