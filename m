Return-Path: <antonio@meshcoding.com>
Message-ID: <529B9EB8.8080306@meshcoding.com>
Date: Sun, 01 Dec 2013 21:40:24 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <20131130230518.GC16735@n2100.arm.linux.org.uk>
 <529A8276.9060002@meshcoding.com> <529B47AA.8060403@meshcoding.com>
 <20131201.142135.880608909113540809.davem@davemloft.net>
In-Reply-To: <20131201.142135.880608909113540809.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors with
	batman-adv
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
Cc: netdev@vger.kernel.org, linux@arm.linux.org.uk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/12/13 20:21, David Miller wrote:
> From: Antonio Quartulli <antonio@meshcoding.com> Date: Sun, 01 Dec
> 2013 15:28:58 +0100
> 
>> Am I wrong or this is a problem in the ARM compiler not doing
>> the right assumption? On x86 and x86_64 offset_of dest is 4, as
>> expected.
> 
> These alignment behaviors are defined by the processor ABI, there
> is no set of global rules that apply, so it behaves differently on 
> different CPUs.  What you observe is correct behavior for
> compilation on ARM processors.
> 

Ok. So, as far as I understand from your and Russell's explanation,
the only way to allow ARM to support batman-adv is to ensure that all
the _structures_ (no matter if it is a parent structure or not) sent
over the wire have a size multiple of 32bits.

If we want to fix this, I think we have to re-work a little more the
packet layout before 3.13 is released.


People using batman-adv on ARM-equipped smartphones (and similar) will
be happy about this :)



Thanks to both for the hints and for the explanations.


- -- 
Antonio Quartulli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKbnrgACgkQpGgxIkP9cwc0ygCdHPgWg1SxUmyQOyC1xR+uNzkr
zfYAn3cEXLSMfxTCkP3CYibehI7D66tA
=AYNJ
-----END PGP SIGNATURE-----
