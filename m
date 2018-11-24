Return-Path: <jiri@resnulli.us>
Date: Sat, 24 Nov 2018 11:23:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20181124102310.GB2511@nanopsycho.orion>
References: <20181123161359.13342-1-sven@narfation.org>
 <20181124092955.GA2511@nanopsycho.orion>
 <2704410.j1Xe82xyVQ@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2704410.j1Xe82xyVQ@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 00/19] batman-adv: netlink restructuring, part 2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

Sat, Nov 24, 2018 at 10:44:18AM CET, sven@narfation.org wrote:
>On Samstag, 24. November 2018 10:29:55 CET Jiri Pirko wrote:
>[...]
>> This looks great. Nice job!
>> 
>> Do you have a userspace app to communicate with this? Would be nice to
>> play with it or at least to see examples of usage.
>
>I have only published the the mcast parsing portion [1] because the 
>application would first need to get a more complex compatibility layer to 
>support netlink and sysfs at the same time.
>
>And I will definitely not spend the time in implementing this kind of stuff 
>when the kernel part is potentially rejected again. But you can get some infos 
>about functionality of the sysfs implementation in the manpage [2].

Okay.

>
>Kind regards,
>	Sven
>
>[1] https://patchwork.open-mesh.org/patch/17659/
>[2] https://manpages.debian.org/stretch/batctl/batctl.8.en.html


