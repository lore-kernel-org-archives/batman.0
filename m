Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 18 Nov 2016 11:33:27 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161118103327.GB4255@otheros>
References: <1479373493121113@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1479373493121113@kroah.com>
Subject: Re: [B.A.T.M.A.N.] Patch "batman-adv: fix splat on disabling an
 interface" has been added to the 4.8-stable tree
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

On Thu, Nov 17, 2016 at 10:04:53AM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     batman-adv: fix splat on disabling an interface
> 
> to the 4.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      batman-adv-fix-splat-on-disabling-an-interface.patch
> and it can be found in the queue-4.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> From 9799c50372b23ed774791bdb87d700f1286ee8a9 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
> Date: Thu, 6 Oct 2016 01:43:08 +0200
> Subject: batman-adv: fix splat on disabling an interface
> [...]

Does anyone know whether I should mail Greg, asking him not to apply it?
Or is the revert of this commit supposed to trickle through soon
anyways?
