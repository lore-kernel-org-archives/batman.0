Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:41:26 +0800
Message-ID: <18492403.daOuMBLdry@diderot>
In-Reply-To: <1384366492-27310-9-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-9-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4017110.K3oIgTWNkB";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 8/8] batman-adv: add debugfs support to
	view multiif tables
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


--nextPart4017110.K3oIgTWNkB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:52 Simon Wunderlich wrote:
> +/**
> + * batadv_originators_open_multiif - handles debugfs output for the
> + *  originators_multiif table
> + * @inode: inode pointer to debugfs file
> + * @file: pointer to the seq_file
> + */
> +static int batadv_originators_open_multiif(struct inode *inode,
> +					   struct file *file)
> +{
> +	struct net_device *net_dev = (struct net_device *)inode->i_private;
> +	return single_open(file, batadv_orig_multiif_seq_print_text, net_dev);
> +}

Please find a better name than 'multiif'. That term isn't used in any function 
your patchset introduced. How about: batadv_originators_iface_open() ?


> +/**
> + * batadv_orig_multiif_seq_print_text - writes originator infos for all
> + *  outgoing interfaces
> + * @seq: debugfs table seq_file struct
> + * @offset: not used
> + *
> + * Returns 0
> + */
> +int batadv_orig_multiif_seq_print_text(struct seq_file *seq, void *offset)

Same here.

Cheers,
Marek

--nextPart4017110.K3oIgTWNkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWTGAAoJEFNVTo/uthzATN4IAI/HE+cMB4/JDU8T/lu45rwQ
eO+Qd1lkaTT319r1Q0oOK3+FM88Gc32g1Ystr1u5yl4HOl1Q5tP3+AmWCkdintrL
DJ4YN7aykU8satjG0oSZF9heveoLzpVAd02kPSbuDzPbt4wLiw12JqJ7NLBVv6au
3pv/rTS17Ol5V3aql4L6+aRlGqSdiYmcZf0iyxPDUWocgffTQFEQDy/4doWDEndq
YVb9h4r4P4cyEmSf71Vtt1bAEjMRqvZ6PL8ztjoF4JbAtPiTsSc5p0pRDCjILdxM
VhuYQtpvxX5fPgwe1EIFCRb9tx3rsHmGk2dHJVSaBz2UQFtNXnGfc5kARWC8AAg=
=9UD4
-----END PGP SIGNATURE-----

--nextPart4017110.K3oIgTWNkB--

