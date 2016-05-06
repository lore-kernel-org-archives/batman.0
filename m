Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 09:10:46 +0800
Message-ID: <5650532.vUQLghqurR@voltaire>
In-Reply-To: <1462474003-25279-4-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <1462474003-25279-4-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8628467.ZIyUFzmFvm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: split routing API data
	structure in subobjects
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

--nextPart8628467.ZIyUFzmFvm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 02:46:40 Antonio Quartulli wrote:
> @@ -638,10 +638,10 @@ int batadv_gw_client_seq_print_text(struct seq_file
> *seq, void *offset) goto out;
>  
>         seq_printf(seq,
> -                  "      %-12s (%s/%i) %17s [%10s]: advertised uplink
> bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
> -                  "Gateway", "#", BATADV_TQ_MAX_VALUE, "Nexthop",
> "outgoingIF", -                  BATADV_SOURCE_VERSION,
> primary_if->net_dev->name,
> -                  primary_if->net_dev->dev_addr, net_dev->name);
> +                  "      Gateway      (#/%i)           Nexthop
> [outgoingIF]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s,
> MainIF/MAC: %s/%pM (%s)]\n", +                  BATADV_TQ_MAX_VALUE,
> BATADV_SOURCE_VERSION,
> +                  primary_if->net_dev->name, primary_if->net_dev->dev_addr,
> +                  net_dev->name);

Please merge this into patch 5.

Thanks,
Marek
 
--nextPart8628467.ZIyUFzmFvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK+8WAAoJEFNVTo/uthzAKDMH/3SnLmccPjad0jO3Yr24eIE2
UPH/fPHsMTnX7xvrATe3v4EjdnInPMrneRMKGoN1gUwmAnCb6FsxEPkgRHYDHegi
9YewyYZE/0UUNTTkPp2P39Bw0FAqRSUCT6Y8BkyvkWaWuOrotUo5ocvZFe5noefI
bFAmcTer3Pr1D58lB/kFtAIhj4O+GrO77J/qOU52Wyzc+TE/QWIMGn0IJvWNQ5s4
5NtEwL+qzhmoTdpiPpAq3c/yfetEHJMyIgamRHwChO2Trer/h8HJ5Y+68E1ZRHs3
CM8+iBdpcjl837d4VBghLBwsTLULVaQ7hj/IU3fAigh8cyAuWks6RScbkfEj6lQ=
=vTIT
-----END PGP SIGNATURE-----

--nextPart8628467.ZIyUFzmFvm--

