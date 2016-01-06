Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jan 2016 20:05:07 +0100
Message-ID: <3614408.8CNzbHmZCJ@sven-edge>
In-Reply-To: <CA+HVqbtX5OX01kGjA7yhYnTFM18kN2ZetvKtkuK3Ptoxrtkp9A@mail.gmail.com>
References: <CA+HVqbtX5OX01kGjA7yhYnTFM18kN2ZetvKtkuK3Ptoxrtkp9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3402921.NsEXDmQCL7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Compiling Batman-adv on Kernel 4.4+
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
Cc: fred veldini <fred.veldini@gmail.com>

--nextPart3402921.NsEXDmQCL7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 January 2016 12:19:04 fred veldini wrote:
> I sent an email to the list a while ago, not sure if anyone received the
> message.

Usually I ignore mails which are send to me directly about batman-adv without 
Cc'ing the mailing list. But I trust that you (at least) tried to send a mail.

But I never saw your mail in the queue of pending mails (maybe Marek did). 
Please send your mails next time as plain text and not with html content.

At least I could find that your mail bounced on Jan 4 17:17:17. So you should 
have been informed that it was rejected (for whatever reason).

> I'm running into an issue compiling the latest batman-adv code on the
> latest kernel,

[...]
> /mnt/builds/batman-Jan-5-2016/batman-adv-6219a1b/net/batman-adv/hard-interfa
> ce.c:469:2: error: too few arguments to function
> 'netdev_master_upper_dev_link' In file included from
> /mnt/builds/batman-Jan-5-2016/batman-adv-6219a1b/compat-include/linux/netdev
> ice.h:25:0, from include/linux/etherdevice.h:26,
>                  from

You don't use an official kernel and the compat layer of batman-adv can only 
support major releases or Linus' development tree. But you can try to change 
the netdev_master_upper_dev_link compat layer under compat-
include/linux/netdevice.h. Try replacing all "KERNEL_VERSION(4, 5, 0)" with 
"KERNEL_VERSION(4, 4, 0)" or whatever the LINUX_VERSION_CODE of your 
development kernel is.

I guess this is causing the problem because you use changes which are for 
Linux 4.5 but your kernel still uses the LINUX_VERSION_CODE for Linux 4.4

Kind regards,
	Sven
--nextPart3402921.NsEXDmQCL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWjWVjAAoJEF2HCgfBJntGFrQP/3CHjDHQRChKLf7Xl6BASeZC
LwAV8wE0FwbeicftmE5j+jI/7CTkMtrVHVEYoEbnZ261Q/N7eGoqkBNbk8HKsnre
ZazwXoDORyuUOa5iRfG/Fo+0qMaARlYYBtVc9AciivYm9wJIZsBAn0ucogMjRlZ/
Sq0TBL0skE2rwdKbxb0Gf8DtWPOuLMJvYt4mKUatktTTk6pxsuNn9BytS3zzNZA/
wgcQxnLSk5R92gP7Z8kdWAuqeC40kC25muE4Ty+VAWANs6QYgXmbWwcaIjSMQcEp
mwTJ4n6HfVG8V2KtSsm+RYQD0PivJ/MfHfF3O/3Xj72guD+dpEKlsH5/oLI1VlEA
JYA3TdijtF4i2b70e+35UQNsrILntu6eMjjKSYJ2Iw7P+ZlMr57EurRN3qqsT1zt
p1Pz9uM4VoE0cylwrE5vxdBxY1AyY/Pl7u5jB6b80r8wfamWnrxUXkHGzmSqAX35
rBTGgn3T1Lml2NJLqARAzsuIi3wKP1qIQe6A21z+v82VNl3AMJOA2IAzEn8Q2Fi8
UW0qNJKx4RR1IljQJxX6tVzH+gqxC931Vj/Mgb5PQxspFFaOaf9DLzTrr+JAXyqi
IXG9FvqQgEBNqSKmLexkcjNXPQVbKiVyhDxTgzBXnTv7Ts4MGXriz2jbA4hbo2aV
sAChZ9O73PvubUSJknS3
=4ZX1
-----END PGP SIGNATURE-----

--nextPart3402921.NsEXDmQCL7--

