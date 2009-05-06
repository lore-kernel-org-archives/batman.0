Message-Id: <08B01611-F186-4533-9CC2-AA16BF92FEF7@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200905061315.09151.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 6 May 2009 07:48:03 +0200
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<200905060006.19114.lindner_marek@yahoo.de>
	<bad82a80905051111t8acb76aoedb7d57c3d42141e@mail.gmail.com>
	<200905061315.09151.lindner_marek@yahoo.de>
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


On 06 May 2009, at 07:15 , Marek Lindner wrote:

> On Wednesday 06 May 2009 02:11:57 Arc Riley wrote:
>> I haven't found any such video on the website.  Is the vis server =20
>> setup for
>> batman-adv or just the layer 3 batman?  Is the protocol used for =20
>> nodes to
>> announce their status documented?
>>
>> We're building a desktop/mobile app using OpenStreetMap data and =20
>> Mapnik, we
>> don't want to require Internet access to view available nodes from =20=

>> any
>> user's connection to the mesh so that it can be used to view and =20
>> diagnose
>> the network in any situation.  If that software could listen to the =20=

>> node
>> status announcements ("I have X quality link with node A, Y quality =20=

>> link
>> with node B, Z quality link with node C"), along with nodes =20
>> announcing
>> other properties including long/lat, wifi protocol and signal, etc, =20=

>> this
>> should be very easy to show colored links indicating their quality.
>>
>> Since we need local link status from nodes, and not the compiled =20
>> quality to
>> route to any node, listening to OGM frames is not enough.
>
> What you want is the vis server that does all that for you. In the /=20=

> proc
> filesystem you will find a file called "vis" which outputs all the =20
> data you want
> in the well-known dot draw format. You can use any dot draw parser =20
> to generate
> a map for your mesh.
> Basically, this vis server is quite similar to the layer 3 vis =20
> server but it
> is integrated into the module (no additional programs needed - just =20=

> activate
> it).


Hi Arc,

If you'd like you can also take look at:

   http://code.google.com/p/afrimesh/

The project is very young and still under heavy development but it =20
does have working code using client-side Javascript & the =20
OpenStreetMap libraries to draw mesh maps from the vis server.

A couple of caveats though:

   1) My development environment is running layer-3 B.A.T.M.A.N.
      and I haven't even thought yet about any potential issues
      running layer-2.

   2) I've patched the layer-3 vis daemon with a command-line
      option to output the mesh map in JSON format rather than
      dot as I found it a tad more amenable to abuse. (Btw, is
      this something anyone else would find useful? I'd be happy
      to clean up & contribute the patch!)

  - antoine



--
http://7degrees.co.za
"Libr=E9 software for human education."

