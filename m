Return-Path: <felix@kaechele.ca>
Subject: Re: [PATCH] batman-adv: compat: Fix build on RHEL 8.1 and clones
References: <20200125180745.19517-1-felix@kaechele.ca>
 <3489864.0R65RLHByN@sven-edge>
From: Felix Kaechele <felix@kaechele.ca>
Message-ID: <2187ec70-4276-5178-b7ad-d029bd8561fb@kaechele.ca>
Date: Tue, 28 Jan 2020 12:19:16 -0500
MIME-Version: 1.0
In-Reply-To: <3489864.0R65RLHByN@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

On 2020-01-25 2:17 p.m., Sven Eckelmann wrote:

> I am personally not really happy about supporting all kind of weird Linux
> kernel forks.

No worries. Just saw that there are some provisions for Debian (which I 
guess is what some of the maintainers are using) in the code. But I do 
see that all the Ubuntu specific stuff that backports has isn't in there 
either.

> Anyway, if you really want to maintain the RHEL support (for reasonable
> versions which are based on reasonable new upstream kernels) then I would
> propose to avoid this RHEL_81. Instead it might be better to just add
> RHEL_RELEASE_VERSION + RHEL_RELEASE_CODE [1] to
> compat-include/linux/version.h. And then just use them like the backports.git
> is using them [2].

I'm not interested in maintaining this upstream indefinitely and I agree 
with you that carrying around fixes for all kinds of weird quirks is a 
burden on maintainers.

I'm happy to just carry this patch in my DKMS RPM packages I maintain 
for batman-adv.

Regards,
Felix
