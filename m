Message-ID: <49183B54.10106@dd19.de>
Date: Mon, 10 Nov 2008 14:47:00 +0100
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] batman - how does "fast
	internet	connection"	connection work
References: <1225349370.13082.53.camel@desiree> <49098068.80606@lo-res.org>
In-Reply-To: <49098068.80606@lo-res.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

aaron schrieb:
> david johnson wrote:
>> Hi
>>
>> First an introduction - I am a David Johnson - I've been working on mesh
>> protocols for a few years now and I've built a 49 node wireless grid to
>> benchmark mesh protocols in South Africa:
>> http://wirelessafrica.meraka.org.za/wiki/index.php/49-node_Indoor_Mesh
>>
>> Elektra and I did some experiments with batman (do I have to use the
>> dots @#!!!) and olsr at the beginning of the year and we wrote a paper
>> showing how batman outperforms olsr on CPU usage and better throughput
>> due to less flapping. The results were very impressive!
>>   
> 
> Well, it is interesting that you note that.
> I read the PDF. One thing that struck me was that the settings for OLSR
> were such that OLSR used *full flooding*. (MPR 7 etc)
> That is *exactly* NOT what it is meant to do!

yes, the MPR idea was a good idea, in theorie.

as i heard, it did not work out at all and made the mesh even more unstable.

i think, the problem was in the way of selecting MPR, but i don't
remember exactly, elektra did a very good explanation that time, some 2
or 3 years ago.

it is quite sad to see that knowledge lost in the current OLSR developer
community.

elektra, could you be so nice and enlight aaron on the topic of problems
with the MPR selection?

> So I must object to the objectivity of the study.
> Basically the study was comparing an elephant and a wale
> Well.. both are great ideas :) But ... they do live in different terrain
> and under different assumptions :)))
> 
> got me?

please calm your temper.

...

>> Thanks and look forward to becoming part of the discussion
>>
>> David

Alex

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkYO1QACgkQhx2RbV7T5aEaRwCfVw47gRH1mVfwVj0Qqxbh37e2
m7kAn1nT6v6EeMdQrJucI+iEs+grbZEl
=a2lu
-----END PGP SIGNATURE-----
