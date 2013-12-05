Return-Path: <antonio@meshcoding.com>
Message-ID: <529FD011.2090508@meshcoding.com>
Date: Thu, 05 Dec 2013 02:00:01 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
 <1386013113-25471-3-git-send-email-sw@simonwunderlich.de>
 <529CEA90.3010709@meshcoding.com> <201312031154.37297.sw@simonwunderlich.de>
In-Reply-To: <201312031154.37297.sw@simonwunderlich.de>
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
Hash: SHA256

On 03/12/13 11:54, Simon Wunderlich wrote:
> Hey Antonio,
> 
>> On 02/12/13 20:38, Simon Wunderlich wrote:
>>> struct batadv_icmp_header { uint8_t  packet_type; @@ -208,18 
>>> +211,16 @@ struct batadv_icmp_header { uint8_t  dst[ETH_ALEN]; 
>>> uint8_t  orig[ETH_ALEN]; uint8_t  uid; +	uint8_t  rr_cur; +
>>> __be16 seqno; };
>> 
>> seqno was not in the header on purpose because new features may
>> need a larger seqno space (e.g. the bw meter uses 32bits long
>> seqnos). I think we have to re-work this structure differently..
> 
> ah ok, didn't know that. Well I also thought to move that uid into
> the other structures to have the icmp header at 16 bytes, but then
> we need to access the icmp_packet instead of icmp_header in
> functions like batadv_socket_write() - I changed that just
> recently. ;)
> 
> What do you suggest? These new types can't work with 16bit seqnos?
> :)
>> 

No, we can;t use 16bit seqnos for that...sorry :)

Right now I don't have a clear solution in mind. I'll try to look at
that header closely tomorrow.


Cheers,

- -- 
Antonio Quartulli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSn9AQAAoJEEKTMo6mOh1VyCUQAJhyn+YJIUznEHq/U3GkIvy7
q2rXosmUKmZX5wxdXQDOPkVzUGRwBf2azNq77F7oIjnzJ/oGCJKOKtvPZ6gFzH/l
MeSEgk3LZ6RjEHPO46lVFM5YeaF5V/xZzuFVUaEfU4mOlotFYqMlJeeDWmCA8lzV
eglll0q7xwHAJkmD0Dg8qh/Yqep+lmjF4RNYz4QTP4VShyWP5swX9EedoocnZ1Rp
COFgCV0ZwpV95PIrX/cnrE7qX7VNJfqJdyL7S8Nabfd1pdhxE1j45I0CdETPszSs
hdN6tgQjcghQUwVAauXyy4oU51B0ISjjcV3Oi9CyLIxS7wF1SwnlHHL5R0Lt372/
WPm62gAhM7qHjOTQGPZ+Z7Ap/qSxXO6nmUMEJUPdXJYmVlg2ZkryPPEFD4SzDfPl
8fnWjtmO06yo3WMIozTqav+ZCNt/qinyt/JDINV+Pos7oxW9JZFF1vWyo1NZyljW
R88GmwOnPoMvPL0M6O4d+I3wrEMHI0MFNLkP6GAiRzC/HhiuYxgoCZj47kLtrb+U
Dtc0Ix7cuvvUt3GC4xBAXJ/12fGljldXRrcVVQkoluboVpgls8RScbCztET/dpTr
1QQhUWFgiR7BSP1lZyZDu3hxFiPBOBCqzcmEXQ+Po1HYyzOB1Ju4X1JCNIrxBcvO
SZ/IhMR6OWuI61qhv7GN
=3QQX
-----END PGP SIGNATURE-----
