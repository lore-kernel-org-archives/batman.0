Return-Path: <anatoliy.lapitskiy@gmail.com>
Message-ID: <550A8AAE.4000802@gmail.com>
Date: Thu, 19 Mar 2015 10:37:02 +0200
From: Anatoliy <anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
References: <1426579875-28365-1-git-send-email-anatoliy.lapitskiy@gmail.com>
 <1970447.8TMetPNtZg@sven-edge>
In-Reply-To: <1970447.8TMetPNtZg@sven-edge>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] alfred: Add "--update-command"
	parameter
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
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Thank you for your patience :)

Anatoliy

On 03/18/2015 09:17 PM, Sven Eckelmann wrote:
> On Tuesday 17 March 2015 10:11:15 Anatoliy Lapitskiy wrote:
>> The "--update-command" parameter is created for adding a hook to run when
>> new information is received.
>>
>> At the moment "alfred-facters" are run by cron once per every 5 minutes.
>> For some tasks (like sharing dhcp leases) it can be too slow.
>>
>> Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
>> ---
>>  alfred.h     | 11 +++++++++
>>  main.c       | 12 +++++++++-
>>  man/alfred.8 |  4 ++++
>>  recv.c       | 10 ++++++++
>>  server.c     | 74
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 5 files
>> changed, 110 insertions(+), 1 deletion(-)
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
>
> Thanks for your contribution
>
> Kind regards,
> 	Sven

