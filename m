Message-Id: <1F63FEA4-ED42-48C5-B45E-87BF3764F4BB@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <1231872376-21395-1-git-send-email-sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 13 Jan 2009 23:29:25 +0200
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
	<1231872376-21395-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Compile vis under FreeBSD and OSX
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


On 13 Jan 2009, at 20:46 , Sven Eckelmann wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Tuesday 13 January 2009 11:52:35 Antoine van Gelder wrote:
>> Some additional includes are required to compile the B.A.T.M.A.N.
>> visualization daemon under FreeBSD and OSX.
> Hm, the headers are also needed on other plattforms. In linux we  
> have deep includes in some headers but this must not be always that  
> way. I would say that they should be included in all supported  
> plattforms.
> Maybe you can have a look at my patch so I didn't messed up the osx  
> support (dont have an OS X here to test it).


Compiles fine under FreeBSD and OSX, tx!


> PS: Interested in porting batmand again to *bsd plattforms?


Possibly - it would be nice to have the option to mesh with a beastie :)

Do you have a rough idea of what broke since it last worked ?

  - antoine


