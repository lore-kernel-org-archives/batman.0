Return-Path: <dominik@heidler.eu>
In-Reply-To: <4946773.CRg2Vnx3gp@sven-edge>
References: <56113660.8080506@heidler.eu> <5450614.1BWUbN25GJ@sven-edge>
 <6D3C26E9-B62A-4577-B738-E21AC08114F4@heidler.eu>
 <4946773.CRg2Vnx3gp@sven-edge>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
From: Dominik Heidler <dominik@heidler.eu>
Date: Sun, 04 Oct 2015 18:30:48 +0200
Message-ID: <94F9A17D-72A5-473F-8FF0-1C843724BB6A@heidler.eu>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Is the hook executed as well when the data is pushed from another master node?

Regards,
Dominik

Am 4. Oktober 2015 18:27:54 MESZ, schrieb Sven Eckelmann <sven@narfation.org>:
>On Sunday 04 October 2015 18:22:54 Dominik Heidler wrote:
>> ah so the update hook is only executed, when the master gets the data
>update
>> via UDP. In my testsetup I updated the master data directly via Unix
>socket
>> on  the master.
>
>Correct. Usually you don't need to inform the local  system that the
>system 
>itself updated the state of the alfred data :)
>
>But feel free to discuss it with Anatoliy here on the mailing list (so
>we can 
>follow the pros/cons of a design change).
>
>Kind regards,
>	Sven

