Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 03 May 2016 12:30:40 +0200
Message-ID: <3771281.MWFGszot8n@bentobox>
In-Reply-To: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1766439.FuRp8GVGVh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: a@unstable.cc

--nextPart1766439.FuRp8GVGVh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

[....]
> +static int originators_callback(struct nl_msg *msg, void *arg)
> +{
[...]
> +
> +=09if (!genlmsg_valid_hdr(nlh, 0)) {
> +=09=09fputs("Received invalid data from kernel.", stderr);
[...]
> +
> +=09orig =3D nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
> +=09neigh =3D nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
> +
> +=09if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),=

> +=09=09=09    ifname))
> +=09=09ifname[0] =3D '\0';
> +
> +=09if (attrs[BATADV_ATTR_FLAG_BEST])
> +=09=09c =3D '*';
> +
> +=09last_seen_msecs =3D nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS=
]);
> +=09last_seen =3D (float)last_seen_msecs / 1000.0;
> +=09last_seen_secs =3D last_seen_msecs / 1000;
> +=09last_seen_msecs =3D last_seen_msecs % 1000;
> +
> +=09/* skip timed out originators */
> +=09if (opts->read_opt & NO_OLD_ORIGS)
> +=09=09if (last_seen > opts->orig_timeout)
> +=09=09=09return NL_OK;
> +
> +=09if (attrs[BATADV_ATTR_THROUGHPUT]) {
> +=09=09throughput_kbits =3D nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]=
);
> +=09=09throughput_mbits =3D throughput_kbits / 1000;
> +=09=09throughput_kbits =3D throughput_kbits % 1000;
> +
> +=09=09if (!(opts->read_opt & USE_BAT_HOSTS)) {
> +=09=09=09printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1=
u) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",

It looks like the header line is missing here. The debugfs table show
something like:

    "  Originator      last-seen (#/255)           Nexthop [outgoingIF]=
:   Potential nexthops ...\n");

or

    "  Originator      last-seen ( throughput)           Nexthop [outgo=
ingIF]:   Potential nexthops ...\n");

the nexthops are also done differently now (not sure if this is better
but at least something which should be discussed):

originator
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

netlink
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
     * 02:ba:de:af:fe:02    0.004s   (251) 02:ba:de:af:fe:02 [      eth=
0]

debugfs
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0 BATMAN_IV)]
      Originator      last-seen (#/255)           Nexthop [outgoingIF]:=
   Potential nexthops ...
    02:ba:de:af:fe:02    0.024s   (251) 02:ba:de:af:fe:02 [      eth0]:=
 02:ba:de:af:fe:02 (251)

The output "No batman nodes in range ...\n" also isn't there anymore
(not that I would miss it).


claimtable
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

netlink
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
    Client               VID      Originator        [o] (CRC   )

debugfs
=2D------

    Claims announced for the mesh bat0 (orig 02:ba:de:af:fe:01, group i=
d 0x9053)
       Client               VID      Originator        [o] (CRC   )


gateway
=3D=3D=3D=3D=3D=3D=3D

netlink
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
       Router           TQ      Next Hop        outgoingIf   Bandwidth

debugfs
=2D------
          Gateway      (#/255)           Nexthop [outgoingIF]: advertis=
ed uplink bandwidth ... [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MA=
C: eth0/02:ba:de:af:fe:01 (bat0)]
    No gateways in range ...


transtable_global
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

netlink
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
           Client         VID Flags Last ttvn     Via        ttvn  (CRC=
       )
     * 1a:fd:d4:3b:b9:06    0 [....] (  2) 02:ba:de:af:fe:02 (  2) (0x3=
6e70691)
     * 33:33:ff:3b:b9:06   -1 [....] (  2) 02:ba:de:af:fe:02 (  2) (0x7=
77c331a)
     * 01:00:5e:00:00:01   -1 [....] (  2) 02:ba:de:af:fe:02 (  2) (0x7=
77c331a)
     * 1a:fd:d4:3b:b9:06   -1 [....] (  1) 02:ba:de:af:fe:02 (  2) (0x7=
77c331a)
     * 33:33:00:00:00:01   -1 [....] (  1) 02:ba:de:af:fe:02 (  2) (0x7=
77c331a)

debugfs
=2D------

    Globally announced TT entries received via the mesh bat0
           Client         VID  (TTVN)       Originator      (Curr TTVN)=
 (CRC       ) Flags
     * 1a:fd:d4:3b:b9:06    0   (  2) via 02:ba:de:af:fe:02     (  2)  =
 (0x36e70691) [....]
     * 33:33:ff:3b:b9:06   -1   (  2) via 02:ba:de:af:fe:02     (  2)  =
 (0x777c331a) [....]
     * 01:00:5e:00:00:01   -1   (  2) via 02:ba:de:af:fe:02     (  2)  =
 (0x777c331a) [....]
     * 1a:fd:d4:3b:b9:06   -1   (  1) via 02:ba:de:af:fe:02     (  2)  =
 (0x777c331a) [....]
     * 33:33:00:00:00:01   -1   (  1) via 02:ba:de:af:fe:02     (  2)  =
 (0x777c331a) [....]

Odd to exchange the order of the flags. @Antonio, do you see some probl=
em in
it? It seems to be nice because now tg and tl look similar.


transtable_local
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

netlink
=2D------

    [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:=
fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
        Client         VID Flags    Last seen (CRC       )
    f2:f2:2d:c3:71:8c    0 [.P....]   0.000   (0xd56fb81f)
    f2:f2:2d:c3:71:8c   -1 [.P....]   0.000   (0x01d52e50)
    01:00:5e:00:00:01   -1 [.P....]   0.000   (0x01d52e50)
    33:33:ff:c3:71:8c   -1 [.P....]   0.000   (0x01d52e50)
    33:33:00:00:00:01   -1 [.P....]   0.000   (0x01d52e50)

debugfs
=2D------

    Locally retrieved addresses (from bat0) announced via TT (TTVN: 2):=

           Client         VID Flags    Last seen (CRC       )
     * f2:f2:2d:c3:71:8c    0 [.P....]   0.000   (0xd56fb81f)
     * f2:f2:2d:c3:71:8c   -1 [.P....]   0.000   (0x01d52e50)
     * 01:00:5e:00:00:01   -1 [.P....]   0.000   (0x01d52e50)
     * 33:33:ff:c3:71:8c   -1 [.P....]   0.000   (0x01d52e50)
     * 33:33:00:00:00:01   -1 [.P....]   0.000   (0x01d52e50)




I personally think that the new common header is nice and should be kep=
t. "No
..." lines could also be be dropped. The header to the originators shou=
ld be
added again and I am not sure about the new format (but cannot say anyt=
hing
bad about it because it follows the style used in other debugfs files).=


@Simon, could this new originator format be problematic when there is
alternating/bonding?

Kind regards,
=09Sven
--nextPart1766439.FuRp8GVGVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKH3QAAoJEF2HCgfBJntGFtYP/RHWxd4LlJa4F0VoqYOMhQDL
HfLwBIIKM8gzlHiX6g/YQD5klwi09kR26fienSRRxWHXnyzg6MSwMwHFqslU8ZaJ
KDZcWxoismeLhaIhTw/QHuxZNWpCxkysRyqTQ9uAR+xjBtNcqDXL9ct3RHlMsG/U
StS4io/zfsoVcY9NPc6gqOO76XU+Ey4JdE6yytr1Z9CR2Rx0wAUVTfDfBVotfcI9
+cP0j7zrHW8E4e9a0u7pgr39VHnVBfNjxTy9FNECUcteJSa9GBudtqQ/Zc7n69ZH
El5KLxAb/x7n4KCkLWbnE+05/ujGpjBrWWTN1RRtzLntkNXupX1LvCh4ugAGo3hw
v6/MuJr5hOWlLeiettHetc2NhIhh8r6c0bJFKlPQ5qeVdeArs8peCyZj9EIxhobY
AG7QIW7MlEjSVkI45W264VCa1VaP0EuYU9FBGOMX9jIlaA02Sfw3pGK5Do2yvlx3
s+dkkCaGWC/YORhamn32WEr2PYqn0tTv2NRNJab3hkk3J5XjD6g3mP7L2PxYJEF0
dGLl9JF+M+RYeA2NOMND9zWMBeZVLr18mNW2I6tGLPDn0rJvL9ADdOQxRwRI7+cb
rA0Jy+EDPgh0Q8wxvWp1gU0FbezrqvlEPjzD/iGhwEoDdv4twFtai3CKKe4SKjs5
/hIsWG5Q+bGs++lwRCtN
=aTez
-----END PGP SIGNATURE-----

--nextPart1766439.FuRp8GVGVh--

