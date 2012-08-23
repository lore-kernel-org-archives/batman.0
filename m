Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Aug 2012 16:21:56 +0200
Message-ID: <1512568.fRsqxxKJDW@bentobox>
In-Reply-To: <1345729318-12804-2-git-send-email-montik@autistici.org>
References: <1345729318-12804-1-git-send-email-montik@autistici.org>
 <1345729318-12804-2-git-send-email-montik@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1463479.DnD1XRnaGP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: bandwidth meter
	implementation
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1463479.DnD1XRnaGP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 23 August 2012 15:41:58 Edo Monticelli wrote:
>  /* ICMP message types */
> -enum batadv_icmp_packettype {
> -       BATADV_ECHO_REPLY              = 0,
> +enum icmp_packettype {
> +       BATADV_ECHO_REPLY               = 0,
>         BATADV_DESTINATION_UNREACHABLE = 3,

I heavily protest against the change of the enum name back to the pre-prefix 
name.

There is still a TODO inside the diff and you have variables which are 
assigned but not used.

Kind regards,
	Sven
--nextPart1463479.DnD1XRnaGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQNjyEAAoJEF2HCgfBJntGRAIQAKJxxIAVBKaQAAbQKuuSBnrV
043BOo6zm4XvAvli21woDWngPw0BxEf3xVGnpjSdPtxAKrEJXgFkr1JFAJu5jtsp
h3u1ivBcPb4u43m3w/PSYeYPdgMP5hNseAZYUdwjYyKf9Kgyv2mnBo/jhU8B4OhR
ELTcwuE6PKvuOKnHxBTQFwYjLmgiWx42zVTbRVXC44xjyHF9nogSFBaQlNiS/gwH
pYDrjKxizFAUjOqo1iLT6FjYUAFUhQDXIVzWnl1eKBigP/Zu35eCCU7sOWeg+qro
CzJFTBds2KXqGVyVUs2PrRP25CDZQqGGmotiTwCzX0nX726y0JdJsg7dqc3jIAlm
TZ7WVI8B7FZo0SI8z61um/O0jL/bnEgh4ogHDG13wGW094U+xGIibi4bEuk6PNaF
6wTw2yHeRrGDxHUz/5k++wE0ThNr8hBKMJ8BPq/zX3s+WXZhXmh990prkeT2DGMv
JRuWuiMqJwsEYuytBfxtS9T1Mm3UoHkNYFWonz3IqSmtYDyWIFCqqxv6yHJzuzyh
Bt46u0WA4NNOHsSLYZ0GE+Fv9Zsqkj4U8ZV6eVE7+fQKwCTtNCa2D+HGKvzIxH/B
NTxZX3yfKcdRcSnaNED68eIeWFRLUCLztcO9cmIYVd15DLyWGhByuLDIZdcXWsGz
xS3F5qt+PgnufFl+NPLs
=+zQz
-----END PGP SIGNATURE-----

--nextPart1463479.DnD1XRnaGP--

