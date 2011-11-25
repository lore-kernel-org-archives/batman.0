Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Nov 2011 13:02:36 +0800
References: <1320750809-12445-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1320750809-12445-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111251302.37267.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: correct usage of
	TT_CLIENT_ROAM flag
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, November 08, 2011 19:13:29 Antonio Quartulli wrote:
> The TT_CLIENT_ROAM flag has to be set in tt_global_del() only if the latter
> has been invoked by the roaming_advertisement receiving routine. In case
> of changes update (normal operation done on OGM/TT_QUERY receiving) this
> doesn't have to happen. Moreover, a client which roamed to us has to be
> marked as ROAMED, not PENDING. This will make it to be kept for
> consistency purposes until the related change is received within the next
> OGM.

Just a recap of our IRC discussion: Please split this patch as it fixes 
several unrelated issues. Also add information about whether or not these 
patches should be sent to the stable maintainers as well.

Thanks,
Marek
