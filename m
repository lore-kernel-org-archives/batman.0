Return-Path: <jj.sarton@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge> <20161106175007.GE9484@otheros>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <234e2c3a-c666-1d2b-d7e5-f1f88c22dc8e@t-online.de>
Date: Mon, 7 Nov 2016 22:48:29 +0100
MIME-Version: 1.0
In-Reply-To: <20161106175007.GE9484@otheros>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n9UNdVO2kDBQDkhLWG4QlD3DAfoVICwCD"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n9UNdVO2kDBQDkhLWG4QlD3DAfoVICwCD
Content-Type: multipart/mixed; boundary="70NUfi4wrHRB1V4C2oDJMRT4JIhE2pM1g";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <234e2c3a-c666-1d2b-d7e5-f1f88c22dc8e@t-online.de>
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge> <20161106175007.GE9484@otheros>
In-Reply-To: <20161106175007.GE9484@otheros>

--70NUfi4wrHRB1V4C2oDJMRT4JIhE2pM1g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo Linus,

I must think about the need of rebroadcast. I agree
that message may be lost. The tcp/ip stack has the
charge of resolving such problems. For udp the partner
may accept packet loss, for example streaming of video
or sound, or have an own protocol for resolving this.

The layer 2 broadcast message are normally important and
sending occur as event. The frame may be lost. If the lost
is on the originator, nobody will become a message.
The packet lost may occur far from the originator an one or
more participant may not get the frame. If all systems are
in the wifi mesh network (each has neighbor with different
connection to the internet), forwarding shall allow
that the frame arrive via the wifi mesh devices. For
system which has no neighbor, the possibility of packet
lost is much greater and only broadcasting more time
may resolve the problem. Sending a broadcast back
can only considered as an acknowledgement. If there
are not more "acknowledgement" as known systems
(gw + node) some participant should not have got
the frame and the originator has to send the broadcast
again.

If I have a look to the clients connected via
wifi on a node broadcasts originated by the client
must not reach the node, but I have not notified
problems due to lost of ARP and so on. The only think
I can see is a lot of arp an rs mainly from smartphones.

There are probably a lot of thinks I have not understood
regardinh the mesh network.

Regards,

Jean-Jacques

Am 06.11.2016 um 18:50 schrieb Linus L=C3=BCssing:
> On Sat, Nov 05, 2016 at 11:25:38PM +0100, Sven Eckelmann wrote:
>> This can be wrong (as explained in my last mail). Gluon only sets the
>> no_rebroadcast on the Freifunk router because it doesn't have to handl=
e
>> distribution of broadcast to multiple fastd endpoints. It would be
>> completely wrong when set on the fastd server (handling multiple clien=
ts).
>> See my other mail for details.
>=20
> Just as a small addition, I think I've said it in the ticket, too:
> Jean-Jacques, in one point, you're absolutely right:
>=20
> When there is just one neighbor on an interface, then rebroadcasts
> can easily be avoided. Which is the case in your scenario on the
> VPN client(!) side.
>=20
> Gluon has this extra patch for batman-adv, this no_rebroadcast
> knob. But an automatic detection which should cover this specific
> VPN client case, was merged into upstream batman-adv just a few
> days ago \o/ :).
>=20
>=20
> For any case with more than one neighbor on an interface it is
> very hard to detect whether upon receiving a broadcast all other
> neighbors have received this broadcast too.
>=20
> If we can't say for sure, then we unfortunately need to stay safe
> and rebroadcast to avoid horrible packet loss / broken connections /
> armageddon.
>=20



--70NUfi4wrHRB1V4C2oDJMRT4JIhE2pM1g--

--n9UNdVO2kDBQDkhLWG4QlD3DAfoVICwCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgg9q0WHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C2E4AJ9cOYUEO36DyTcS1u6MYlNtnh9LGQCfeKvy2EbsKgWeOmoLkYVzyxx0wWQ=
=rIc9
-----END PGP SIGNATURE-----

--n9UNdVO2kDBQDkhLWG4QlD3DAfoVICwCD--
