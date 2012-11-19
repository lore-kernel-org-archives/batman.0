Return-Path: <bhutchings@solarflare.com>
Message-ID: <1353351150.4156.4.camel@bwh-desktop.uk.solarflarecom.com>
From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 19 Nov 2012 18:52:30 +0000
In-Reply-To: <1353313451-2930-5-git-send-email-ordex@autistici.org>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
 <1353313451-2930-5-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: export compatibility
 version via debugfs
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net

On Mon, 2012-11-19 at 09:24 +0100, Antonio Quartulli wrote:
> Different versions of the batman-adv module may use the same compatibility
> version, but this is not understandable at runtime (the only way is to parse the
> kernel log and fetch the batman-adv advertisement message on loading). The user
> may want to know whether two nodes using different versions can communicate or
> not. For this purpose the module has to export this value through debugfs.
[...]

I do hope that you're not planning to use unstable debugfs interfaces
indefinitely.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

