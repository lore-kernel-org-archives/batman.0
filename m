Return-Path: <linus.luessing@web.de>
Date: Sun, 7 Nov 2010 17:50:46 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101107165046.GA25042@Sellars>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
	<1289148361-16019-4-git-send-email-linus.luessing@web.de>
	<201011071703.36509.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201011071703.36509.sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add sequence number and
 duplicate checks for unicasts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Ah, thanks, oki doki.

I'm rectracting my Signed-off-by for now anyway, as I couldn't
validate their effect yet. However, any feedback if this idea
might or might not possibly work / make sense anyway is very
welcome :).

Cheers, Linus

On Sun, Nov 07, 2010 at 05:03:29PM +0100, Sven Eckelmann wrote:
> On Sunday 07 November 2010 17:46:01 Linus Lüssing wrote:
> >  /* this file is included by batctl which needs these defines */
> > -#define COMPAT_VERSION 12
> > +#define COMPAT_VERSION 13\
> 
> Please increase that to 14. 13 is already used in linux 2.6.37(-rc1)
> 
> Best regards,
> 	Sven


