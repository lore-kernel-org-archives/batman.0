Return-Path: <antonio@meshcoding.com>
Message-ID: <529CEA90.3010709@meshcoding.com>
Date: Mon, 02 Dec 2013 21:16:16 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
 <1386013113-25471-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1386013113-25471-3-git-send-email-sw@simonwunderlich.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 3/4] batman-adv: fix size of
	batadv_icmp_header
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/13 20:38, Simon Wunderlich wrote:
> struct batadv_icmp_header { uint8_t  packet_type; @@ -208,18
> +211,16 @@ struct batadv_icmp_header { uint8_t  dst[ETH_ALEN]; 
> uint8_t  orig[ETH_ALEN]; uint8_t  uid; +	uint8_t  rr_cur; +	__be16
> seqno; };
> 

seqno was not in the header on purpose because new features may need a
larger seqno space (e.g. the bw meter uses 32bits long seqnos).
I think we have to re-work this structure differently..

rr_cur was not in the header because it is only used by the PING and
not by all the others ICMP packets. But having it in the header is
harmless I think.


Cheers,

- -- 
Antonio Quartulli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKc6pAACgkQpGgxIkP9cwdUkgCeNYm2xfFIIKO8OL2TJ9au7rQe
4ncAnieIgls5N4Ea+939rMD2taypkJP5
=nWqI
-----END PGP SIGNATURE-----
