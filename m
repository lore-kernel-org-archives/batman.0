Return-Path: <linus.luessing@web.de>
Date: Thu, 11 Mar 2010 18:14:08 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100311171407.GA11121@Linus-Debian>
References: <20100309230308.GB30949@Linus-Debian>
	<1268325529-10998-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +		if ((vis_packet->seqno - old_info->packet.seqno) > 127) {
If anyone might have a more generic solution instead of using the
fixed of 127 without having to utilise math.h, that'd be great.

Ok, and no some more words to the tests and discussions with Marek
yesterday and their results.

> What I also just noticed is, that when I refresh the vis-output
> every second only the TQ values of _2_ entries at a time  get updated,
> the other ones are static for quite a while. However, looking at
> wireshark tells me, that I'm still getting a vis-packet of all
> other 4 nodes                                                            =
                    =20
> every second. So it looks like the vis-server might not be always
> updating its vis_hash to me, but not sure about that.
The issue seemed to be the thing I just sent a patch for. Pfeh,
then I didn't see any ghost bug which was sometimes there and
sometimes not. I started to doubt about the setup a lot first :).

> I'd expect all 5 nodes to have a direct connection to all other 4
> nodes. However, for instance 06:22:b0:98:87:f9 is just having
> three. A couple of seconds later, the missing entry is there
> again, but other ones can be missing.
The line which is causing this behavior is in generate_vis_packet():
------
398                 if (orig_node->router !=3D NULL
399                         && compare_orig(orig_node->router->addr,
400                                         orig_node->orig)
------
It turned out that this is not a bug and that it was intended to
leave out those vis entries. Looks like I had slightly different
expectations at the vis-server. I wanted to see all possible links
and alternative next-hops in the vis-graph while Marek enlightened
me, that this would increase the throughput usage a lot as for
instance a far distant node, from which we'd receive a batman-ogm
up to every 120 seconds would result into a vis-entry then.
So including alternative/non-used next-hops in the vis-output
might need a new discussion.

Cheers, Linus

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLmSTfAAoJEBKw7u43QNpfeSIQAJIIbOq8Grl+AHL1zL+YQT+6
W3ctpVoaiM2o/33oFiYdTOZ4ZJp5VIG4UP+HY0rUPtdzAtR1tiWREEGOxsuX7GX9
POlTglhWp1RsJ8FgVKo2OQ9VbOijbF62PUpFdQ9PmZikYVR4QbvdmJn2EwSUSdte
hLe/Q6Y159xLNvxQRDsvHPhnw6HeX6lUTzsvaCCEEdK22DLIQepAlQbX472M0dJ1
e66Udi3vVMVWGAz51gGC2nu+akErNU9TL0nsrhmj/RFE9Wc/FITQ2ueJXq8OTi+J
Sfv4QosJNG+OKgNqz1kpj9Njh0uvYxGat4YbtthxExIWPhPmcBo6+EBm62YEjHds
E4c/oI7slNty06xElB2zUJfz1kysKqJFHC0yi8/9Ca8kwo4HarEMQoUAjNDPIZni
r8BXyvZba8hTmqdKtRUgGBrFRcKPy3G0FOxV5lqY/u05hLleoCI+8WmWpgvC/8LQ
KvsBvr3E79+Jtz2S2N5ZRVRZBkp+wtxdzr6hCbxDsTUsY235DgKnu295lOjXAUta
YJ7N+3j72jKU31TatG0eRflMtNmmQxfusatEx5BE0nKCl8K4MO3jnzHHEEpipAQB
sCP8QQUmyqe+RWtj0J9iX9AGB09hl7Rvv/S2rMWl9V32mN09b4mQpgpGUmc+RNG9
KE8iRTPF0k7k9jEbpxWd
=67Mg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
