Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Nov 2016 15:28:05 +0100
Message-ID: <2907018.3yHk8Vyvxo@sven-edge>
In-Reply-To: <581C7F4A.80104@yahoo.com>
References: <581C7F4A.80104@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2647230.qdSXNGMFWO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] i have a question ? How many relay nodes can be
	supported at NetworkCoding ( mtu 1546 ) .
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2647230.qdSXNGMFWO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> When i compile the part , whether i need make
> CONFIG_BATMAN_ADV_BATMAN_V=y at batman-adv-2016.2

2016.2 is "old". And BATMAN_V has nothing to do with network coding.

> i read some detail about NetworkCoding , my understanding :
> 
> every relay node will detects neighbors packet at promisc mode and
> combine these packet into a single transmission ,

I think Martin can help here. He also provided some documentation:

* https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding
* https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding-technical
* https://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf
* https://vbn.aau.dk/da/publications/catwoman(214ee21a-e786-495d-85c9-3efac4718ead).html
* https://downloads.open-mesh.org/batman/misc/wbmv4-network_coding.avi

And it will not try to forward each packet is overheard. Instead it
will try to find coding opportunities which it then uses to forward
its own packets in less transmissions (by using packets which the
other nodes should already know).

>               batctl nc 1
>               echo 1 > /sys/class/net/bat0/mesh/network_coding
>               ip link set dev wlan0 promisc on
>               ip link set dev wlan0 mtu 1546

Your cards/drivers will most likely not even support promiscuous mode.
Some of them require to have an monitor mode interface at the same time and
some of them will simply not work.

You can test it by simply checking what tcpdump is showing you on the
underlying interface (wlan0). If it doesn't show you the packets between
two other nodes then promiscuous mode is not working for you.

The feature itself is not used very often (Martin, please correct me here).
It is not enabled by default because it is not making things "better" all
the time [1]. So it is also not tested as much as other components in
batman-adv and you should think first if it is really useful for your
scenario/HW. I knew at least from some Freifunk communities played around
when it was enabled by default but had to revert when they experienced "non
functional mesh links" (nothing more about it is known to me - sorry Martin).


> if i send a packet from host A to hostC via hostB, whether hostB will
> open relay mode at layer2 .

I completely failed to parse this.

batman-adv will send your data from hostA to hostC via hostB when the TQ
value for the link "from hostA to hostC via hostB" is higher than the TQ
value for the link "hostA to hostC directly". This has nothing to do with
network coding and is a standard feature of batman-adv (this is actually
what it is about).

network coding can only (when lucky) try to combine some packets - but
this will only work when promiscuous mode is actually working and the
nodes can overhear packets. Otherwise it will (in theory - Martin please
correct me if I overlooked a safety mechanism) just create a lot of coded
packets which cannot be decoded anymore. This seems to be especially
problematic when some nodes are for example 2x2 MIMO devices and others
are 3x3. At least this would be a good way to let the 2x2 miss important
packets when the 3x3 devices talk between each other.

I would even guess that things like dynamic transmission power would make
overhearing packets also more problematic.

> but i have a question ? How many relay nodes can be supported at
> NetworkCoding ( mtu 1546 ) .

I am not sure what you are asking here. The implementation in batman-adv
can combine two packets into one. And this combining of these two packets
is done by exact one relay node. The decoding is done by the two receiving
nodes. What you can build with it is been shown in the documentation from
Martin. The network coding used here is therefore done by a relay node and
its neighbors. But there can be multiple relay nodes in the mesh doing
network coding at the same time.


I personally haven't used network coding with batman-adv. But since you've
created multiple new threads on the mailing list [1,2,3,4] (beside the
private mail *grml*) - here is at least a pseudo-answer.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding#Drawbacks
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016586.html
[3] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016587.html
[4] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016588.html
[5] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016592.html
--nextPart2647230.qdSXNGMFWO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHex1AAoJEF2HCgfBJntGMtIP/09O/bBSski1zw1ucHI85Lus
c7uNvmNaj9AKLu4O1UYE9vVYe2s92e6rb3VJSGG8A4TXxsWypwv3zCOKW/Ssawdg
VbfLcxXiGgGVivc95TtUwswEJZxHk2S6LpDulmpVSYo7GsqgaEyjD+0We/uf2h+t
TMnCINKQGBkbh/3FJVz8wxSoy7TeRVjx3K3x0FD0bsBs+Mcn9/4p3SoYzobweKmE
NK4gBYZJjTFBK/QQQUzJUsnXf5Ud10WCFAIO48RWnr7pm4jYXVwyPe9cmUoP/H7N
Ff+pXjeQ4KrIytEgSt9C0uI9gyzmA/NEciRDoWuJjUhh3MEL1mq8TeWRGSompUxW
/pwC5UqU4H4V8oE+F4dSi+44gM1ELSaJweiIY/+Oxz15E8HSEz5BjCt4fiYDxumJ
dvwTrWzVYIDn1PUXnlApCqPlDImMS5IdKy0xhZezO8fkEIZmlGXPBCKj30T11KOP
ImzLhknlSTxOmmCo5JH9Po8SKGL5Cwe3aULqy3Ow216XjbqLTPrqfIndpyC6hfkq
EQaMv9MB+lXxgHkS3dodpTsOweEB2/+/UVOqgw5KdKwqNY5bGxJnguvMWd4p52Jt
36dHALrEAHKY8wAd1vyOmwJLd09DSDSmKNSUtRpqWqX+9psfynqKAbvZn9oBVva/
59vvf0seCkEsqDY1J1wZ
=HLG0
-----END PGP SIGNATURE-----

--nextPart2647230.qdSXNGMFWO--

