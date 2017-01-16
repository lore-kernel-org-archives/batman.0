Return-Path: <daniel@iogearbox.net>
Message-ID: <587C9192.6010905@iogearbox.net>
Date: Mon, 16 Jan 2017 10:25:38 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
References: <20170114212803.GF3254@otheros>
 <1484441452.2998.11.camel@decadent.org.uk>
In-Reply-To: <1484441452.2998.11.camel@decadent.org.uk>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Duplicate #include guards with make-kpkg /
 out-of-tree compile errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Manoj Srivastava <srivasta@debian.org>, debian-kernel@lists.debian.org

On 01/15/2017 01:50 AM, Ben Hutchings wrote:
> kernel-package is maintained by Manoj Srivastava (cc'd), not the kernel
> team.
>
> Ben.
>
> On Sat, 2017-01-14 at 22:28 +0100, Linus Lüssing wrote:
>> Hi Ben and others,
>>
>> Recently we stumbled upon some compile errors when trying to build
>> a backport version of the batman-adv kernel module for a 4.5 kernel
>> [0]:
>>
>>      "implicit declaration of function ‘G_TC_AT’"
>>
>> It seems VirtualBox has stumbled over this issue, too [1].
>>
>> When trying to find the cause of these errors we noticed that the
>> headers directory created via "$ make-kpkg kernel_headers" for 4.5
>> kernel resulted in two differing header files with the same guard,
>> namely __LINUX_PKT_CLS_H:
>>
>> https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
>> .5.0%2b/include/uapi/linux/pkt_cls.h
>> https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
>> .5.0%2b/include/linux/pkt_cls.h
>>
>> The latter, the non-uapi version, has the "#ifdef __KERNEL__"
>> section stripped, causing the compile issue if it is included
>> before the uapi variant.
>>
>> Removing this non-uapi version from the unpacked
>> linux-headers .deb package manually afterwards lets
>> a batman-adv compilation succeed again.
>>
>> Daniel (CC) has helped a lot with debugging so far and he
>> expressed the suspicion that maybe make-kpkg might install
>> "$ make headers_install" into the wrong directory?

Just to elaborate why I think it's strange, from above link the
include/linux/ directory contains the normal kernel headers we
have in the source tree, and the include/uapi/linux/ the expected
uapi headers. However, the post-processed uapi header files can
also be found in include/linux/. For example, if there's a name
collision (bpf.h as one example), then the post-processed uapi
header was not installed into include/linux/ and the normal kernel
header can still be seen there. If there was no naming collision
like in pkt_cls.h case, then it gets installed into include/linux/
as well. That seems at least rather strange to me, unless there's
a good reason for doing that which I'm not aware of.

>> Regards, Linus
>>
>> [0]: https://www.open-mesh.org/issues/322
>> [1]: https://www.virtualbox.org/ticket/15327
>>
>> PS: make-kpkg was invoked on a Debian Jessie (kernel-package
>> 13.014+nmu1).

