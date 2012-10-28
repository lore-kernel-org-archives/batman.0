Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
Date: Sun, 28 Oct 2012 20:13:26 +0100
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAGJwzLps+6ZBjmHUmr3zOB8BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: [B.A.T.M.A.N.] batman for production
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
To: 'Sven Eckelmann' <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

hi sven,

first: sorry about replying that way - i have an account but somehow i
couldn't post anything here!

second: i have a working test environment running, all works great, but i am
not familiar with the update mechanism of batman. I don't want to replace
any good version if the latest kernel has already the best possible version
of batman.

third: here are actually my doubts. to configure a mesh within batman you
normally use batctl. so are those patches for batctl or for the batman-adv
itself and how can I get the right batctl corresponding to the batman-adv
version from kernel.org 3.6.3?

or is it even better to configure batman-adv via the sys classes (echo bat0
> /sys/class/net/eth0/batman_adv/mesh_iface)?

thanks a lot,

walter



-----Original Message-----
From: Sven Eckelmann [mailto:sven@narfation.org] 
Sent: Sonntag, 28. Oktober 2012 15:34
To: Walter Robert Ditzler
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Re: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: add kernel-doc for
enum batadv_dbg_level

On Sunday 28 October 2012 14:32:46 Walter Robert Ditzler wrote:
> hi batman list,
> 
> i recently saw there is a bounce of email in the batman community 
> regarding patches.

Please don't reply to a random posts to start a new topic. And don't write
to the Linux networking mailing list and the Linux networking maintainer
David S. 
Miller when you actually want to ask the "b.a.t.m.a.n mailing list".

And yes, you will see patches going over this list the whole time. Either
because somebody wants to get stuff integrated into some B.A.T.M.A.N.
related project or because the patches were sent to our Linux networking god
David S. 
Miller.

So nothing unusal happened.

> is it safe and reliable to use the version from the open-mesh.org
> site:
> 
> - inux 3.6 => batman-adv 2012.3.x (get batctl 2012.3.x from here)

Ehrm, ehrm, ehrm, ehrm, oehm, aehm.... I will not guarantee anything. It is
safe to use this stuff until anyone proofed it otherwise. But we have some
fixes in the maint branch which weren't released yet in form of 2012.3.1 or
2012.4.0. But they are included in the stable releases of Linux 3.6.x

> for production use onto the following configuration:
> 
> os: debian 6.0.6
> kernel: 3.6.3, batman activated
> arch: geode lx and amd64

Now you baffled me completely. Linux 3.6.3 is the stable release which
includes batman-adv 2012.3.0 + stable fixes. And you want to replace it with
2012.3.0 without these stable fixes. Can you give me a reason why this
sounded to you like a good idea? Even without these stable fixes... why
would you replace the in-kernel module with the out-of-tree module of the
same version?

Kind regards,
	Sven

