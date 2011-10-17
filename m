Return-Path: <martin@hundeboll.net>
Message-ID: <4E9C6728.4070709@hundeboll.net>
Date: Mon, 17 Oct 2011 19:34:32 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <4E9C2AA9.4070208@hundeboll.net>
	<20111017163754.GA1646@ritirata.org>
In-Reply-To: <20111017163754.GA1646@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Unused structs in Catwoman packet buffers
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

On 2011-10-17 18:37, Antonio Quartulli wrote:
> Hello Martin,
>
> and thank you for the explanation.
>
> On Mon, Oct 17, 2011 at 03:16:25 +0200, Martin Hundebøll wrote:
>> Now here's the question:
>> When a list of a certain coding_path becomes empty, should I free the coding_path right away, or should I timestamp it and mark it for removal at a later time. The thing is that I don't know whether a new packet for the same coding_path will arrive in a short moment. If I have just freed the coding_path struct, I would have to spend ressources to initialize it again...
>>
>> It is probably a micro-optimiziation and the simplest solution would be to just free it right away, but I would like to have your comments anyways.
>
> In my opinion it would be better to _keep_ the struct even if the corresponding
> packet list is empty.

I agree. I have just made a housekeeping task to clean up other elements, so it shouldn't be a problem to add the coding_path here :)

Thanks!

-- 
Kind regards
Martin Hundebøll

+45 61 65 54 61
martin@hundeboll.net

Nordborggade 57, 2. tv
8000 Aarhus C
Denmark
