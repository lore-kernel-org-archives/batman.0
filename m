Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 15:52:13 +0800
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <201305081311.57379.lindner_marek@yahoo.de> <5327945.UAE3F7hzx2@bentobox>
In-Reply-To: <5327945.UAE3F7hzx2@bentobox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121552.13444.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv-devel: Add missing
	TARGET_* flags to batctl compile
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
Cc: Sven Eckelmann <sven@narfation.org>

On Wednesday, May 08, 2013 15:24:50 Sven Eckelmann wrote:
> On Wednesday 08 May 2013 13:11:57 Marek Lindner wrote:
> > On Tuesday, May 07, 2013 20:51:07 Sven Eckelmann wrote:
> > > The compilation step of batctl completely dropped the TARGET_CFLAGS,
> > > TARGET_CPPFLAGS and TARGET_LDFLAGS and therefore weren't compiled and
> > > linked with the flags given by the OpenWRT build environment.
> > 
> > It seems you missed the meaning of MAKE_BATCTL_ARGS ? This variable
> > contains TARGET_CFLAGS already. We apparently are missing
> > TARGET_CPPFLAGS and TARGET_LDFLAGS. Do you want to resend and make the
> > necessary changes to MAKE_BATCTL_ARGS ?
> 
> I didn't felt like fixing your other problems too, but sent two other
> patches resolving the MAKE_BATCTL_ARGS problem. See
> [Bonus-PATCH 10/9] batman-adv-devel: Don't overwrite batctl's CFLAGS
> [Bonus-PATCH 11/9] batman-adv-devel: Remove unused parameters from
> MAKE_BATCTL_ARGS

Applied with minor modifications in revision f41a85c.

Thanks for the explanations as to why that is helpful.

Thanks,
Marek


