Return-Path: <dominik@heidler.eu>
In-Reply-To: <5450614.1BWUbN25GJ@sven-edge>
References: <56113660.8080506@heidler.eu> <5450614.1BWUbN25GJ@sven-edge>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
From: Dominik Heidler <dominik@heidler.eu>
Date: Sun, 04 Oct 2015 18:22:54 +0200
Message-ID: <6D3C26E9-B62A-4577-B738-E21AC08114F4@heidler.eu>
Subject: Re: [B.A.T.M.A.N.] Alfred update-command
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

ah so the update hook is only executed, when the master gets the data update via UDP.
In my testsetup I updated the master data directly via Unix socket on  the master.

Regards,
Dominik

Am 4. Oktober 2015 18:17:56 MESZ, schrieb Sven Eckelmann <sven@narfation.org>:
>On Sunday 04 October 2015 16:23:28 Dominik Heidler wrote:
>> Hi,
>> 
>> I tried to use the alfred update-command but it seems that the
>> update-command is only triggered when data is purged but not when new
>> data is received.
>> 
>> The changed_data_type() method is only called from the purge_data()
>method.
>[...]
>
>Nope, see finish_alfred_push_data (when data was synced to a master
>node):
>
>		/* check that data was changed */
>		if (new_entry_created ||
>		    dataset->data.header.length != data_len ||
>		    memcmp(dataset->buf, data->data, data_len) != 0)
>			changed_data_type(globals, data->header.type);
>
>It is useless on slave instances because they only pull data when it is
>
>required. But better ask Anatoliy because he is creator of this feature
>and 
>the only one I know who seems to use it.
>
>Kind regards,
>	Sven

