Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 30 Jul 2012 12:12:19 +0200
References: <1343603730-3824-1-git-send-email-ordex@autistici.org>
 <201207301147.03506.lindner_marek@yahoo.de>
 <20120730100704.GG2578@ritirata.org>
In-Reply-To: <20120730100704.GG2578@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207301212.19763.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the WIFI flag from the
	local to global entry
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, July 30, 2012 12:07:04 Antonio Quartulli wrote:
> > And why is this explanation not part of the commit message ?
> 
> Because it is left as exercise for the reader ;-)
> Actually I didn't mention it because the Ap-Isolation part is a
> "consequence". What this patch wants to fix is an issue in the client
> entry state consistency, regardless of the semantic of such state.
> 
> Anyhow, if you think it is worth adding it, I will do that.

Well, we need some explanations *why* we want this change. The way you are 
describing it now it sounds like we want to preserve all relevant flags during 
the transition from local to global client and vice versa ?

Regards,
Marek
