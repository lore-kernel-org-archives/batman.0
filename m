Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <51B3CBD0.9050803@altermundi.net>
Date: Sat, 08 Jun 2013 21:26:56 -0300
From: =?UTF-8?B?Tmljb0VjaMOhbml6?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar> <20130606191823.GJ1789@ritirata.org>
 <51B1E4D6.5000900@inti.gob.ar> <20130607135713.GL1789@ritirata.org>
 <51B1F062.3060101@inti.gob.ar> <20130607144019.GM1789@ritirata.org>
 <51B214AE.2090603@inti.gob.ar> <20130607172734.GO1789@ritirata.org>
 <51B22D19.7080807@inti.gob.ar> <20130608122939.GR1789@ritirata.org>
In-Reply-To: <20130608122939.GR1789@ritirata.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/08/2013 09:29 AM, Antonio Quartulli wrote:
> Hello Gabriel,
> 
> On Fri, Jun 07, 2013 at 03:57:29PM -0300, Gabriel Tolón wrote:
>> 
>> Yes, that's strange, that's why I asked if you had tested the
>> same. It couldn't be due to hardware differences? Just in case
>> WDR3500 have AR9344 SoC.
>> 
> 
> I guess it's the same:
> 
> system type		: Atheros AR9344 rev 2
> 
> and this is one test I just performed:
> 
> # batctl bw a6:86:74:00:0f:12 Bandwidth meter called towards
> a6:86:74:00:0f:12 Test over in 10030ms. Sent 187528500 Bytes. 
> Throughput: 17.83 MB/s (149.57 Mbps)
> 
> There must be something different in our setup that is probably
> triggering a bug in the bw_meter (I guess).
> 
> Here you have more results from tests performed a couple of weeks
> ago.
> 
> 
> Maybe I find a couple of WDR3500 on which I can remotely try to
> debug the problem....

Antonio, maybe you can use the WDR4300 routers from the battlemesh.
Ufo reported on the WBM list they were still available online for
testing. P4u (guifi) also mentioned he has a WDR... testbed.

cheers,
Nico


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRs8vQAAoJEPHORz17N0TFbjMH/jk5RSRz9Hy+5npRWc5JAfcy
CSxzYSy+qsgihiqv6byeBzHV1U7cE/QKTmhWksEPgfqqnjkU+MHkYMwwXDATpR4j
RcXPxPsGVrtCsZEKMIf33Owb+lBC/AUiyfputZefdlNq5c0vt/FCoSAM3Zy1qJJ1
Uzyps85b4aKnlixd9u40XWQ/KewG6R41jgevkECfN77f3ViUBLbQbdK1+om5ytP5
DglNbjUtn/EG8rY/+uRK2jVXsgSj3DDSeutJeakE76JgjdspWA3X8O4/GpHvyiZo
ZqjS5Q+QHyDLSGRlWOb7g/vUAM3xRwrr5un2Hn5gJmQ79qF2G7lBiUDZr3Y7nnk=
=y1R2
-----END PGP SIGNATURE-----
