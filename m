Message-ID: <20080107215209.zr62uc39c0cwsokc@webmail.ddmesh.de>
Date: Mon, 07 Jan 2008 21:52:09 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] one-way / two-way tunnel (was: Memory leak)
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801071045.10747.axel@open-mesh.net>
	<20080107135602.eigmai3tpko40c40@webmail.ddmesh.de>
	<200801071748.36253.axel@open-mesh.net>
In-Reply-To: <200801071748.36253.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
To: b.a.t.m.a.n@open-mesh.net

Hi Axel,

> On Montag 07 Januar 2008, Freifunk Dresden wrote:
>> Hi,
>>
>> The batmand is running on WRT54GL and WRT54GS. The firmware is
>> whiterussian_rc6
>> and the batmand was self-compiled from within whiterussian devel env.
>> I have removed the "-static" LDFLAG and also removed the
>> DEBUG/MEMORY... CFLAGS.
>> As optimation I have used -Os to keep the batmand small which also produces
>> a lot of warnings.
> if you have 30k left, try -O1. Then there should be no warnings.
>
> playing with different optimization levels (all dynamically linked and
> stripped) :
> 194783 b  with -O1  -DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA
> 190675 b  with -O1
> 162019 b  with -O2
> 174247 b  with -O3
If you use option -Os the resulting size is 153815 bytes. I like to
save flash memory as much as possible. But I will try if the optimation level
does solve the problem.
The CFLAGS I have used are -Wall -Os.


> I once did some cpu-load experiments to estimate the benifits of -O1..-O3 and
> could not identify any significant differences between the different compiler
> optimizations.
If this is true then I tend to keep -Os as compile option.

> By the way, at the 24c3 somebody managed to stip more useless data from the
> binaries than I achieved with the whiterussion sstrip. Does anybody know how
> this is possible and what's the difference between strip and sstrip ?
I don't know, but it would be a good Idea if I could configure the batman make
process. For instance I disabled the routing rule settings of batman. Perhaps
there are more thinks that can be disabled if they are not used.

Thanks for the explaination about the GW/tunnel. Will need a deeper look into
your description. If I still have questions, I will ask. :)
/Stephan

