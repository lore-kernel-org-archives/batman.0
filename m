Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 8 May 2013 13:11:57 +0800
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-8-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305081311.57379.lindner_marek@yahoo.de>
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

On Tuesday, May 07, 2013 20:51:07 Sven Eckelmann wrote:
> The compilation step of batctl completely dropped the TARGET_CFLAGS,
> TARGET_CPPFLAGS and TARGET_LDFLAGS and therefore weren't compiled and
> linked with the flags given by the OpenWRT build environment.

It seems you missed the meaning of MAKE_BATCTL_ARGS ? This variable contains 
TARGET_CFLAGS already. We apparently are missing TARGET_CPPFLAGS and 
TARGET_LDFLAGS. Do you want to resend and make the necessary changes to 
MAKE_BATCTL_ARGS ?

Cheers,
Marek
