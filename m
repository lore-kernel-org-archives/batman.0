Return-Path: <johannes@sipsolutions.net>
Message-ID: <1529267306.3070.0.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 17 Jun 2018 22:28:26 +0200
In-Reply-To: <1529229951-17730-1-git-send-email-omer.efrat@tandemg.com>
 (sfid-20180617_120607_305286_FD9A7637)
References: <1529229951-17730-1-git-send-email-omer.efrat@tandemg.com>
 (sfid-20180617_120607_305286_FD9A7637)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/5] use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Omer Efrat <omer.efrat@tandemg.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, devel@driverdev.osuosl.org

On Sun, 2018-06-17 at 13:05 +0300, Omer Efrat wrote:
> 
> Note: The following patch series only does some code clean up.
> The previous versions mentioned a bug fix but it appears as a mix up
> with some local changes because NL80211_STA_INFO_TID_STATS value actually
> equals 31.

Interesting. Thanks for checking!

johannes
