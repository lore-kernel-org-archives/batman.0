Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 04:34:27 +0800
References: <201201230026.09036.lindner_marek@yahoo.de>
	<1327257640-13530-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1327257640-13530-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201270434.27872.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix initialised flag for
	tt request/responses
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

On Monday, January 23, 2012 02:40:40 Simon Wunderlich wrote:
> When receiving a tt_response, we first delete the old entries and
> set the initialised flag to false, then add the new received entries,
> but forgot to set the initialised flag to true again. This may lead to
> endless loops of requests/responses, as a request is always issued
> if the initialised flag is not set.
> 
> This is a regression introduced by
> 8ef201e01c57e3bfbcb7f6db69405ff259c2b907.

Applied in revision e4172b0.

Thanks,
Marek

