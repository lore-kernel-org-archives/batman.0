Return-Path: <sven.eckelmann@gmx.de>
Date: Sun, 14 Mar 2010 16:50:26 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100314155025.GA18908@sven-atom.lazhur.ath.cx>
References: <1268526950.4592.32.camel@rover>
	<20100314120410.GA16678@sven-atom.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20100314120410.GA16678@sven-atom.lazhur.ath.cx>
Subject: Re: [B.A.T.M.A.N.] Strange sequence numbers
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 14, 2010 at 01:04:10PM +0100, Sven Eckelmann wrote:
> Thanks for testing the code. I doubt that this is a bug in the batman-adv code.
> Can you please make a capture of the raw packet data using tcpdump and/or
> wireshark? I think that this is a batctl bug, but I don't have time to check it
> right now. You can do the comparison by yourself using the wireshark-batman-adv
> dissector linked in the open-mesh.net wiki.

Just checked the output of a uml tcpdump versus a tcpdump of the corresponding
tap device on the host. The result on the host ist correct and the output from
the uml has the two bytes from the sequence number exchanged. So it seems that
the skb is changed without cloning the data which is changed.

The problem appears when data is resend by the other node and we retreive them.
It doesn't seem to happen when we receive data from the other node with the
originator also being the other node. This is not the data the network really
sees - only tcpdump will see it.

So it is real a problem with batman-adv and not batctl (the code of batctl
isn't that complex that it could create such a problem).

Best regards,
	Sven

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJLnQXBAAoJEF2HCgfBJntGH5QQAMXQ0WY9bV45dLoSCk+UXf5r
aUpb4899D1z6FPGbz7QbabN2cMCCyRiJVEQehNuj78WzwUDBTxQUkVt2KqFBLsqP
A2jWUToIIAi2w5sWQ2l37cJpgtdWIqp1dwKCc7xSxypMxaZ2uSRhdHE9O39LHQfz
5jayMzF4j0ov5JPhcCRmO42rpC537XWDHz0OUCNrEmRVZSC8WK4kZR6Owsj+72hM
fOkZXfdG/kQvhNvmxlp337sWYbfDH300R19dzqpRUM+yiNdemh2AFYYjEwxOY07V
TkQBX7KZZqD/QSd0UkIK+29+yNs9Ax3RnesR3z9xlen5VdU1KFhvdiKEHXvpY8Xx
NDOjEPoHiBQFj5nMU2gB+Q2/pmk4HcnYyEK6dY1GjMN05inHZfrswUgBSzI0zEkw
mD1m6CrJdjdT3KJoQTUjkPoch21sach/etmyLOwwMPC3o2j6vP73CBgi/KQn8Hnr
qjGgEA8rYJ9md6PyQSvPCkWB0PMOWEhj0Yvm/0ocrUf5lR+x0ngyMhuWPSdickLH
qobZcbihcmwSQusx1a+ex0sfi/TUlz8vhXByyzK0yamBQFr2ITnLBD6PE1arpf9j
cSUCN8NI5JatEC+YD739SttnvYJmQ79tGddZMf79TQo/HSM/Ywvc0Ov8qfo3RdSl
9IMX5sRC8T89Q4sD8No7
=oXDi
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
